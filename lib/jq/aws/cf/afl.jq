include "aws-time";
include "pad";
include "date";

def printLastUpdatedTime:
if . == null then
  "n/a"
else 
  . | pTimedmyhm
end;

# use git branch format committerDate to convert to sg
def mapStackSummary:
"\(.LastUpdatedTime|printLastUpdatedTime|rp(11)) "+
# "\(.LastUpdatedTime|aws_fromdate|ToLocalDateFormatObject("ymdhM"")) "+  
"\(.StackName | trunc(50) | rp(50)) "+
"\(.StackStatus) "+
# "\(.DriftInformation) "+
"\(.TemplateDescription//"" | trunc(70))"
;

def mapRemoveDeleted($all):
  if $all == "true" then
    .
  else 
    map(select(.StackStatus != "DELETE_COMPLETE"))
  end;

def sortBy($sortBy):
  if $sortBy == "name" then
    sort_by(.StackName)
  else 
    sort_by(.LastUpdatedTime) | reverse
  end;


def afl($all; $sortBy):
.StackSummaries 
| sortBy($sortBy)
| mapRemoveDeleted($all)
| map(mapStackSummary)[]
;
