## Stage 1
###Get s3 files , filter for SG users and put in stage1 file
* only get SG users
* only get STAT2, NUM, P_EMAIL, C_EMAIL or USRID_LONG attributes

the format of the file is:
/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/SAP_AWSS3_EmployeeDelta_04032021210114.CSV:2:122863,SG122863,06.05.2020,06.09.2020,NUM0X,+60162192214,D


get the date of each file and put in file_date
/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv 2021-02-17 14:43:02

replace the space in file_date with a , and output file_date2
file_date2
/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,2021-02-17 14:43:02

## Stage 2
###change : to ,

/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,2,106026,SG106026,01.07.2019,31.12.9999,STAT2,3,I

stage2filenames file
/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv

stage2filenamesuniqbase

FileName,FileNameBase
/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,"106026-2021-02-15.csv"

insert this file into the sqlite db as S3 FileName

## Stage 3
###join user row with its file date

/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,2,106026,SG106026,01.07.2019,31.12.9999,STAT2,3,I^M,2021-02-17 14:43:02

## Stage 4
###remove (line feed) ^M in middle of string
\r is carriage return, it means moving the cursor to the beginning of the line
\n is line feed, it means moving one line forward

/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,2,106026,SG106026,01.07.2019,31.12.9999,STAT2,3,I,2021-02-17 14:43:02

## Stage 5
replace USRID_LONG with P_EMAIL (both update the P

/Users/tim/certis/projects/certify/syncReport/production/s3/certify-sapsync-prod-sg/users/uploads/106026-2021-02-15.csv,2,106026,SG106026,01.07.2019,31.12.9999,STAT2,3,I,2021-02-17 14:43:02

## Stage 6

replace NUM01, NUM02, NUM0X and combine all into NUM0X so that group by works
since group by gets the latest within the group

## Stage 7

sort rows ----------------------------------------------------------------
 emp, - column 4
 field (STAT2,NUM0x etc), -column 7
 date descending, - column 9
 file rownum descending - column 2 -r for descending, -n for numeric sort
 without numeric sort, <space>9 and 10 are not sorted the way you expect

 
## Stage 8
for each user, group and sort each attribute

assumption, input must be sorted?
get first row of each group
group by emp id and field
eg SG125387 STAT2 is a group
eg SG125387 NUM0x is another group

## generate attribute files

_s3stat2 
_s3num0x
<!-- * add a + prefix to phone numbers -->
_s3cemail
_s3pemail

## generate cognito files
use helper functions clu, clu2csv to query the cognito user pool and generate a csv file
generate a sign in file

## Generate Error Report

SyncErrorReport is a view in the sqlite3 db
There are error views for each s3 table in the sqlite db
the SyncErrorReport view then uses these view to generate the report

comparing emails is particularly tricky.
* p, c email problem.
* what if c email has a gmail address, then another p email sync is synced?

what if there is only a difference of a + in the phone number, eg s3 does not have +, cognito has a + is it an error?
