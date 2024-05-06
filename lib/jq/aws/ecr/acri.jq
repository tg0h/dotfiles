include "aws-time";
include "pad";
include "date";
include "colour";

def acri:
  .imageDetails 
  | sort_by(.imagePushedAt) | reverse
  | to_entries
  | map(.value.index = .key + 1 ) # add a row number to count the number of images
  | map(.value)
  # | .[0:$_n] 
  | .[] 
  | "\(.index | lp(3)) \(.imagePushedAt ) \(.lastRecordedPullTime // "" | lp(32)) \(.imageSizeInBytes / 1000000 | floor) MB \(.imageTags )"
;
