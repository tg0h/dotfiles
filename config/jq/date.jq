def aws_fromdate:
# if pass in null, return ""
# convert eg 2022-09-30T11:01:31.511000+08:00 to unix time
  if . == null then 
    null
  else
    . [0:19]+"Z" | fromdate
  end;

# return duration in s
# accepts unix time
def _duration_s($startTime;$endTime):
  if ($startTime | type) == "string" or ($startTime | type) == "null" or 
     ($endTime | type) == "string" or  ($endTime | type) == "null" 
  then
    null
  else
    $endTime - $startTime
  end;
