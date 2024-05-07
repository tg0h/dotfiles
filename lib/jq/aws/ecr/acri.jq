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
def getImageDetailsIfExists($sort):
  if $sort == "descending" then
    # no jmespath query was used
    .imageDetails | sort_by(.imagePushedAt) | reverse
  elif $sort == "ascending" then
    .imageDetails | sort_by(.imagePushedAt)
  else
    .imageDetails | sort_by(.lastRecordedPullTime) | reverse
  end
;

def acri($sort; $_n):
  .
  | getImageDetailsIfExists($sort)
  | addRowNumber
  | .[0:$_n].[]
  | printLine
;
