include "pad";
include "colour";
include "colour-scale";
include "aws-time";
include "date";

def _actions_awsPipelineStatus:
{
  "Succeeded": _g("SS"|lp(2)), # grey
  "Superseded": __("SD"|lp(2)), # red
  "Failed": _r("FL"|lp(2)),
  "InProgress": _y("IP"|lp(2)),
  #  "Cancelled": ___(.), # background colours do not work well with padding
};

# 
def _actions_cancelledFilter:
  if .=="Cancelled" then
    ___(.)+"  "
  else
    .
  end;

def actions_aplStatus:
  _actions_awsPipelineStatus[.] // . | _actions_cancelledFilter;

def _approvedRejected:
{
  "Approved by": _g(.), # grey
  "Rejected by": _r(.), # red
};
def approvedRejected:
  if . == null then 
    . 
  else
    # _approvedRejected[.] // . 
    .
  end;

def __actionExecutionStatus:
{
  "Succeeded": _g("S"), # green_bg
  "Failed": _bgr("F"),
  "InProgress": _y("P"),
};
def _actionExecutionStatus:
  __actionExecutionStatus[.] // .;

def _sortStages:
[ 
  "Source",
  "Build",
  "UpdatePipeline",
  "Assets",
  "staging",
  "production"
];

def _pstageCount:
  if   . ==  6 then .|tostring|__(.)
  else
    .|tostring|__(.)
  end;

def _minHighlight_red:
  if   . ==  0 then   .|tostring|lp(2)|__(.)
  elif . ==  1 then   .|tostring|lp(2)|_cs0
  elif . ==  2 then   .|tostring|lp(2)|_cs3
  elif . ==  3 then   .|tostring|lp(2)|_cs5
  elif . ==  4 then   .|tostring|lp(2)|_cs7
  elif . ==  5 then   .|tostring|lp(2)|_cs9
  elif . ==  6 then   .|tostring|lp(2)|_cs10
  elif . ==  7 then   .|tostring|lp(2)|_cs11
  elif . ==  8 then   .|tostring|lp(2)|_cs12
  elif . ==  9 then   .|tostring|lp(2)|_cs13
  elif . == 10 then   .|tostring|lp(2)|_cs15
  else
    .|tostring|_r(.)
  end;
def _hourHighlight_red:
  if   . ==  0 then  .|tostring|lp(2)|__(.)
  else
    .|tostring|lp(2)|_r(.)
  end;

def s_ToDuration_red:
  if . == null then .
  else
    ( . / (60*60) | floor ) as $hour |
    ( (. / 60) % 60 | floor) as $min |
    (. % 60) as $sec |
    "\($hour|_hourHighlight_red|.+__(":"))\($min|_minHighlight_red|lp(2))\("."|__(.))\($sec|tostring|lp(2)|__(.))"
  end;

def getSummaryMinDate:
  (map(.startTime) | min) as $minTime
  | (unique_by(.stageName) | length | _pstageCount) as $stageCount
  | "\($minTime|pTimedm) \($stageCount)"
  ;
# get the duration of the pipeline to display in the summary header
def getSummaryHeaderDuration:
  (map(.startTime) | min) as $minTime
  | (map(.lastUpdateTime) | max) as $maxTime
  | "     \(_duration_s($minTime|aws_fromdate;$maxTime|aws_fromdate)|s_ToDuration_red) \($minTime|pTimehms) \($maxTime|pTimehms) "
  ;
def filterSummaryApprovedBy:
# match 
# "Rejected by arn:aws:iam::...:user/giggsc",
# "Approved by arn:aws:iam::...:user/garyf"
# NOTE: may contain a string if summary provided via cli put approval result reject to deploy newer execution id instead
  (capture("(?<action>(Approved|Rejected) by).*/(?<user>(.*))")
    | if . != null then "\(.action|approvedRejected) \(.user)" else . end)
  //.;

def getSummaryApprovedBy:
  (map(select(.actionName=="DeployToProduction")))[].output
  | if (.|has("executionResult")) then
        .executionResult.externalExecutionSummary 
          | filterSummaryApprovedBy 
          # | "\(.action|approvedRejected) \(.user)"
    else 
      null
    end;
def mapStageHeader($stageName):
  if $stageName == "staging" or $stageName == "production" then
    (map(select(.runOrder == 1) | .startTime) | min) as $stime1
    | (map(select(.runOrder == 2) | .startTime) | min) as $stime2
    | (map(select(.runOrder == 3) | .startTime) | min) as $stime3
    | (map(select(.runOrder == 4) | .startTime) | min) as $stime4
    | (map(select(.runOrder == 5) | .startTime) | min) as $stime5
    | (map(select(.runOrder == 1) | .lastUpdateTime) | max) as $etime1
    | (map(select(.runOrder == 2) | .lastUpdateTime) | max) as $etime2
    | (map(select(.runOrder == 3) | .lastUpdateTime) | max) as $etime3
    | (map(select(.runOrder == 4) | .lastUpdateTime) | max) as $etime4
    | (map(select(.runOrder == 5) | .lastUpdateTime) | max) as $etime5
    # any time below may be null
    | ([ $stime1, $stime2, $stime3, $stime4, $stime5, $etime5 ]) as $maxArr
    | ([ $etime1, $etime2, $etime3, $etime4, $stime5, $etime5 ]) as $maxEndTimeArr
    | ($maxArr + $maxEndTimeArr | max) as $maxEndTime
    # get the max 
    | $maxArr | max as $lastTime
    | _duration_s($stime1|aws_fromdate; $maxEndTime|aws_fromdate) as $stageDuration
    | ($stageDuration|s_ToDuration) as $prettyStageDuration
    | "\($stageDuration|lp(5)) \($prettyStageDuration//"") \($maxArr[0]|pTimehms_y) ->\($maxArr[1]|pTimem|lp(2))->\($maxArr[2]|pTimem|lp(2))->\($maxArr[3]|pTimem|lp(2))->\($maxArr[4]|pTimem|lp(2)) \($maxArr[5]|pTimehms_g//"")"
    # | "\($stime1)
    # \($stime2)
    # \($stime3)
    # \($stime4)
    # \($stime5)
    # \($stime5|aws_fromdate)
    # \(_duration_s($stime1|aws_fromdate; $etime5)) 
    # "
  else
    (map(select(.runOrder == 1) | .startTime) | min) as $stime1
    |(map(select(.runOrder == 1) | .lastUpdateTime) | max) as $etime1
    | (($etime1|aws_fromdate) - ($stime1|aws_fromdate)) as $stageDuration
    | ($stageDuration|s_ToDuration) as $prettyStageDuration
    | ([ $stime1, $etime1]) as $timeArr
    | "\($stageDuration|lp(5)) \($prettyStageDuration) \($timeArr[0]|pTimehms_y) \($timeArr[1]|pTimehms_g)"
  end;

