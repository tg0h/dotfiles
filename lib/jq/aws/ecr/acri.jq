include "aws-time";
include "pad";
include "date";
include "colour";

def addRowNumber:
   to_entries
  | map(.value.index = .key + 1 ) # add a row number to count the number of images
  | map(.value)
;

def printDatetime:
  if . == null then
    "" | rp(14)
  else 
    . 
    | ToSeconds
    | ToLocalDateFormatObject("ymdhM") # Convert to local time date object 
    | FormatDate(.) # pretty print
  end
;

def printLine:
   "\(.index | lp(3)) "+
   "\(.imagePushedAt | printDatetime) "+
   "\(.lastRecordedPullTime | printDatetime) "+
   "\(.imageSizeInBytes / 1000000 | floor) MB "+
   "\(.imageTags )"
;

# the input data depends on if a jmespath query was used
def getImageDetailsIfExists:
if (.|type == "object") then
  # no jmespath query was used
  .imageDetails | sort_by(.imagePushedAt) | reverse
else
  # a jmespath query was used
  .
end;

def acri:
  .
  | getImageDetailsIfExists
  | addRowNumber
  | .[] 
  | printLine
;
