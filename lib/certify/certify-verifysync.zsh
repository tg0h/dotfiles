#!/usr/local/bin/zsh #this is the location of homebrew zsh
# to change shell, add the homebrew zsh path, /usr/local/bin/zsh to /etc/shells, then chsh -s to /usr/local/bin/zsh, then restart mac
#
# dependencies:
#  gstat - need to brew install coreutils
#  gsed - brew install gsed
#  csvcut - need to sudo pip install csvkit. To install, brew install pyenv, pyenv install (python version) x.y.z then pip install csvkit
#  trash - npm install -g trash-cli
#  xsv - manipulate csv files - from git BurntSushi/xsv - brew install xsv
#
# the plist file is stored in ~/Library/LaunchAgents/certify-validate-sync.plist
# consider using the launch control app to configure this
# TODO: if running the script manually, where to output the echo command?
# TODO: add timestamp to SyncErrorReport attachment in email

mkdir -p /tmp/certify-verifysync
echo certify-verifysync ran at: $(date) >> /tmp/certify-verifysync/log

path=('/usr/local/bin' $path) # add homebrew packages
path=('/usr/local/opt/sqlite/bin' $path) # add homebrew sqlite3 to path (do not use macos sqlite which is an older version)
export PATH

echo this is path $path

# TODO: this is a code smell
. $HOME/.dotfiles/config/zsh-boot/zshrc #get everything
# cerp p #get env variables
as cp

# WORKING FOLDER FOR THE REPORT ------------------------------------------------------------------------------------
cd $_CERTIFY_VERIFY_REPORT_FOLDER_TMP
trash $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/*

csync #get latest dom report and latest user

local start=$(date +%s)
# TODO: enclose fields with ""
# TODO: phone number handle +
# TODO: use dom's patch file

## add a row number for a file
# -s add a comma after the number
# -n, specify number format rz = right justified, leading zeroes
# gnl -s, -nrz test > out

# show line numbers with -n
echo stage 1
echo filtering SG User attributes from s3 to stage1
# rg -n '.*,SG.*(,STAT2,|,NUM..,|,P_EMAIL,|,C_EMAIL,|,USRID_LONG,)' $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER >stage1
# only get SG users, ignore HK users
rg -n '.*,SG.*(,STAT2,|,NUM..,|,P_EMAIL,|,C_EMAIL,|,USRID_LONG,)' $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER >stage1

#n is name
#w is creation date
#.19 means first 19 chars
# zsh throws an error "argument list too long" if there are too many files in the folder
# gstat -c '%n %.19w' $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER >file_date
for file in $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER/*; # note that / after $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER
do
  # echo $file
  gstat -c '%n %.19w' $file >> file_date
done

gsed -E 's/^(.*.CSV) /\1,/gI' file_date | sort >file_date2 #replace space after filename  with comma

#replace colon after filename with comma
#replace blah.csv:45:field1,field2,... to blah.csv,45,field1,field2,
echo stage 2
gsed -E 's/^(.*.CSV)(:)([0-9]+)(:)/\1,\3,/gI' stage1 | sort >stage2

# -d - the delimiter is ,
# -f1 - only get the first field in stage2
cut -d, -f1 stage2 > stage2filenames

#get unique filenames from stage2filenames
cat stage2filenames | sort | uniq > stage2filenamesuniq
while read file
do
  echo $file,$(basename $file) | gsed -E 's/(.*),(.*)/\1,"\2"/'
done < stage2filenamesuniq > stage2filenamesuniqbase

# use gsed to add a header row
# -i - edit in place
gsed -i '1i FileName,FileNameBase' stage2filenamesuniqbase
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from S3FileName;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/stage2filenamesuniqbase S3FileName
EOF
# parallel -a stage2filenames basename > stage2basenames ## too slow, has 147k records


#combine s3 with file dates
echo stage 3
join -t, stage2 file_date2 >stage3

# remove (line feed) ^M in middle of string
# \r is carriage return, it means moving the cursor to the beginning of the line
# \n is line feed, it means moving one line forward
echo stage 4
gsed -E 's/\r//g' stage3 >stage4

# ---------------------------------- DE DUPLICATE FIELDS INTO SAME  GROUP--
#replace USRID_LONG with P_EMAIL (both update the P
#does this preserve sorting?
echo stage 5
gsed -E 's/,USRID_LONG,/,P_EMAIL,/I' stage4 >stage5

#replace NUM01, NUM02, NUM0X and combine all into NUM0X so that group by works
#since group by gets the latest within the group
echo stage 6
gsed -E 's/,NUM..,/,NUM0X,/I' stage5 >stage6
############################################################################

#sort rows ----------------------------------------------------------------
# emp, - column 4
# field (STAT2,NUM0x etc), -column 7
# date descending, - column 9
# file rownum descending - column 2 -r for descending, -n for numeric sort
# without numeric sort, <space>9 and 10 are not sorted the way you expect
echo stage 7
sort -t, -k4,4 -k7,7 -k10,10r -k2,2nr stage6 >stage7

#assumption, input must be sorted?
#get first row of each group
#group by emp id and field
#eg SG125387 STAT2 is a group
#eg SG125387 NUM0x is another group
echo stage 8
gawk -F, '!a[$4$7]++' stage7 >stage8

#separate into 4 files
#sort so that you can join later
#must sort on the join column
echo generating s3 user attribute files

rg ',STAT2,' <stage8 | sort -t, -k4,4 >_s3stat2
#add column headers
# -i edit in place
gsed -i -E 's/([0-9]{2})\.([0-9]{2})\.([0-9]{4})/\3-\2-\1/g' _s3stat2 #change date format from dd.mm.yyyy to yyyy-mm-dd
gsed -i '1i File,FileRow,EEId,GlobalId,StartDate,EndDate,Field,Value,Status,FileCreateDate' _s3stat2
csvcut -c 3,4,5,6,7,8,9,1,2,10 _s3stat2 >s3stat2
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from s3stat2;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/s3stat2 s3stat2
EOF
# skip 1st header row
#.import <filename> <table name> - import this csv file into this table

rg ',NUM0' <stage8 | sort -t, -k4,4 >_s3num0x #can be NUM03 etc TODO:
# gsed -i '1i file,filerownum,"EE ID","Global ID","Start Date","End Date","Field Name","Field Value",Status,FileCreateDate' s3_num0x
gsed -i -E 's/([0-9]{2})\.([0-9]{2})\.([0-9]{4})/\3-\2-\1/g' _s3num0x #change date format from dd.mm.yyyy to yyyy-mm-dd
gsed -i '1i File,FileRow,EEId,GlobalId,StartDate,EndDate,Field,Value,Status,FileCreateDate' _s3num0x
# gsed -E 's/NUM0X,([0-9])/NUM0X,+\1/g' _s3num0x >__s3num0x #add + prefix to phone numbers
csvcut -c 3,4,5,6,7,8,9,1,2,10 _s3num0x >s3num0x
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from s3num0x;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/s3num0x s3num0x
EOF

rg ',C_EMAIL,' <stage8 | sort -t, -k4,4 >_s3cemail
# gsed -i '1i file,filerownum,"EE ID","Global ID","Start Date","End Date","Field Name","Field Value",Status,FileCreateDate' s3_cemail
gsed -i -E 's/([0-9]{2})\.([0-9]{2})\.([0-9]{4})/\3-\2-\1/g' _s3cemail #change date format from dd.mm.yyyy to yyyy-mm-dd
gsed -i '1i File,FileRow,EEId,GlobalId,StartDate,EndDate,Field,Value,Status,FileCreateDate' _s3cemail
csvcut -c 3,4,5,6,7,8,9,1,2,10 _s3cemail >s3cemail
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from s3cemail;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/s3cemail s3cemail
EOF

rg ',P_EMAIL,' <stage8 | sort -t, -k4,4 >_s3pemail
# gsed -i '1i file,filerownum,"EE ID","Global ID","Start Date","End Date","Field Name","Field Value",Status,FileCreateDate' S3Pemail
gsed -i -E 's/([0-9]{2})\.([0-9]{2})\.([0-9]{4})/\3-\2-\1/g' _s3pemail #change date format from dd.mm.yyyy to yyyy-mm-dd
gsed -i '1i File,FileRow,EEId,GlobalId,StartDate,EndDate,Field,Value,Status,FileCreateDate' _s3pemail
csvcut -c 3,4,5,6,7,8,9,1,2,10 _s3pemail >s3pemail
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from s3pemail;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/s3pemail s3pemail
EOF

##get user.csv containing cognito users
##to generate users.csv, run clu and clu2csv
echo "copying cognito users.csv"
clu #get list of cognito users (json)
clu2csv #convert list of cognito users to csv
cp $_CERTIFY_COGNITO_LOCAL_USERS.csv .
# TODO: relative file path code smell?
echo get sg users
rg '^"SG.*' <users.csv >userssg.csv
gsed -i '1i GlobalId,EEId,Name,GivenName,FamilyName,EmploymentStatus,JoinDate,UserStatus,PhoneNumberVerified,PhoneNumber,EmailVerified,Email,CompanyEmail,PersonalEmail,UserCreatedDate,UserLastModified' userssg.csv
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
delete from User;
.mode csv
.import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/userssg.csv User
EOF

# cp $_CERTIFY_COGNITO_SIGNINS .
# echo get sign in attempts
# # TODO: get latest signins?
# gsed -i '1i Username,EventResponse,EventType,CreationDate,RiskDecision,CompromisedCredentialsCreated,ChallengeName,ChallengeResponse' signins
# sqlite3 $_CERTIFY_VERIFY_DB <<EOF
# delete from SignIn;
# .mode csv
# .import --skip 1 $_CERTIFY_VERIFY_REPORT_FOLDER_TMP/signins SignIn
# EOF

#joining on EE ID fails because of dirty data where EE ID is ./Desktop/SAP data/timfix-missingEmpId-all-1-700.csv:128706
#join on Global ID instead
# echo join to stat2
# what is this for ?!?!
# xsv join --left GlobalId userssg.csv GlobalId s3stat2 >join1.csv
# xsv join --left GlobalId join1.csv GlobalId s3num0x >join2.csv
# xsv join --left GlobalId join2.csv GlobalId s3cemail >join3.csv
# xsv join --left GlobalId join3.csv GlobalId s3pemail >join4.csv # join cognito users with latest s3 attributes

# SyncErrorReport is a view in the sqlite3 db
# There are error views for each s3 table in the sqlite db
# the SyncErrorReport view then uses these view to generate the report

echo generating error report
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
.headers on
.mode csv
.output SyncErrorReport.csv
Select * from SyncErrorReport order by SyncDate desc;
EOF

# TODO: == performs pattern matching. it doesn't work?
# use -eq 0 instead
# pass filename to wc via standard input so that wc does not output the filename along with the count
# [[ $(wc -l <SyncErrorReport.csv) -eq 0 ]] && rm SyncErrorReport.csv

gn #run the gn function to update the current time into the $now global var
local phonePatchFileName=timfix_"$now"_phoneNumberFix.csv

echo generating phoneNumber patch
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
.headers on
.mode csv
.output $phonePatchFileName
Select * from user_phoneNumber_patch order by 'Global Id'
EOF

[[ $(wc -l <$phonePatchFileName) -eq 0 ]] && rm $phonePatchFileName
echo "cleaning up phne number patch if it exists"

local empStatusPatchFileName=timfix_"$now"_empStatusFix.csv
echo generating employmentStatus patch
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
.headers on
.mode csv
.output $empStatusPatchFileName
Select * from user_employmentStatus_patch order by 'Global Id'
EOF

[[ $(wc -l <$empStatusPatchFileName) -eq 0 ]] && rm $empStatusPatchFileName

echo "cleaning up employmentStatus patch if it exists"

local emailPatchFileName=timfix_"$now"_emailFix.csv
echo generating employmentStatus patch
sqlite3 $_CERTIFY_VERIFY_DB <<EOF
.headers on
.mode csv
.output $emailPatchFileName
Select * from user_email_patch order by 'Global Id'
EOF

[[ $(wc -l <$emailPatchFileName) -eq 0 ]] && rm $emailPatchFileName

echo "cleaning up email patch if it exists"

# echo generating error report
# sqlite3 $_CERTIFY_VERIFY_DB <<EOF
# .headers on
# .mode csv
# .output SyncErrorEmploymentStatus.csv
# Select * from SyncErrorEmploymentStatusReport;
# EOF

local errorCount=$(($(wc -l <SyncErrorReport.csv) - 1)) #subtract header row from file
if [ $errorCount -gt 0 ]; then
  # error thrown if attaching file that does not exist
  # echo "Errors found in Sap Sync" | mutt -s "SAP Sync Error Report" ***REMOVED*** -a SyncErrorReport.csv -a phoneNumberPatch.csv -a employmentStatusPatch.csv
  echo "Errors found in Sap Sync" | mutt -s "SAP Sync Error Report" ***REMOVED*** -a SyncErrorReport.csv
fi

# if patch file exists, email it
[ -f $phonePatchFileName ] && echo "phone number patch" | mutt -s "SAP Sync Error Report phone number patch" ***REMOVED*** -a $phonePatchFileName
[ -f $empStatusPatchFileName ] && echo "employment status patch" | mutt -s "SAP Sync Error Report employment status patch" ***REMOVED*** -a $empStatusPatchFileName
[ -f $emailPatchFileName ] && echo "email patch" | mutt -s "SAP Sync Error Report email patch" ***REMOVED*** -a $emailPatchFileName

mkdir -p /tmp/certify-verifysync
echo certify validate sync finished at: $(date) >> /tmp/certify-verifysync/log
