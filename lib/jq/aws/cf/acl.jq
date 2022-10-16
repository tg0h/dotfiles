include "aws-time";
include "pad";

def printLastUpdatedTime:
if . == null then
  ""
else 
  . | pTime
end;

def mapStackSummary:
"\(.LastUpdatedTime|printLastUpdatedTime|rp(11)) "+
"\(.StackName | rp(30)) "+
"\(.StackStatus) "+
"\(.DriftInformation) "+
"\(.TemplateDescription//"" | trunc(40))"
;

def mapRemoveDeleted($all):
  if $all == "true" then
    .
  else 
    map(select(.StackStatus != "DELETE_COMPLETE"))
  end;

def acl($all):
.StackSummaries 
| mapRemoveDeleted($all)
| map(mapStackSummary)[] ;
