include "colour";
include "aws-time";
include "date";
include "colour-scale";
include "pad";
include "aws/codepipeline/apa/header/getExecutionHeader";
include "aws/codepipeline/apa/header/mapStageHeader";
include "aws/codepipeline/apa/detail/_detail";
include "aws/codepipeline/apa/_utils/setDuration";
include "sort";
include "aws-pipeline"; # sort keys

def sortStages:
  addSortKey("name";_sortStages) | sort_by(.sortKey);
def groupIntoStages:
  # group into [ {name: "production", actions: [...]}, name: "staging", actions: [...]]
  group_by(.stageName) | map({name: (first.stageName), actions: .});

def header($stageName; $rpPadding):
  # processing a eg {name: "staging", actions: [ ... ]}
    "\(_orange(.name|rp($rpPadding))) \( .actions
    | map(setRunOrder($stageName))
    | mapStageHeader($stageName))"
    ;

def mapStages($summary):
  # processing a eg {name: "staging", actions: [ ... ]}
  if $summary == "true" then
    .name as $stageName | header($stageName; 20)
  else
    .name as $stageName | header($stageName; 46), detail($stageName)
  end
  ;

def _entry($oneline;$pipelineStatus;$summary):
  if $oneline == "true" then
    .actionExecutionDetails | getExecutionHeader($pipelineStatus)
  else
    .actionExecutionDetails |
    (
      getExecutionHeader($pipelineStatus),
      (
        .[0:] 
        | groupIntoStages 
        | sortStages
        | map(mapStages($summary))
        | .[]
      )
    )
  end
  ;
