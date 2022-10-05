def aws_fromdate:
# convert eg 2022-09-30T11:01:31.511000+08:00 to unix time
. [0:19]+"Z" | fromdate;
