include "sort";
include "aws/codepipeline/apa/detail/setMaxDuration"; #getMaxArray
include "aws/codepipeline/apa/detail/printActions";
include "aws/codepipeline/apa/_utils/setDuration";
include "aws-pipeline"; # sort keys

def sortActions($stageName):
  if $stageName == "Assets" then
    sort_by(.actionName[9:] | tonumber) 
  else
    # use _sortKeys defined in aws-pipeline.jq
    addSortKey("actionName";_sortKeys) | sort_by(.runOrder, .sortKey)
  end;

def detail($stageName):
    .actions
    | map(setDuration)
    | map(setRunOrder($stageName))
    | sortActions($stageName)
    | getMaxArray as $maxarray
    # | getMaxStartTimeArray as \$maxStartTimeArray
    | map(setMaxDuration($stageName;$maxarray))
    | map(printActions($stageName; $maxarray))
    | .[]
    ;
