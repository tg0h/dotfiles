include "aws-time";
include "pad";
include "date";

def printLastUpdatedTime:
if . == null then
  "n/a" | rp(14)
else 
  . 
  | aws_fromdate # Convert to Unix timestamp
  | ToLocalDateFormatObject("ymdhM") # Convert to local time date object 
  | FormatDate(.) # pretty print
end;

def mapStackSummary:
"\(.LastUpdatedTime|printLastUpdatedTime) "+
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
