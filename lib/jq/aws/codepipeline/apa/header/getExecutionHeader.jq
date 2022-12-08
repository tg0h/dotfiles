include "colour";
include "aws-time";
include "pad";
include "date";
include "colour-scale";
include "null";

def _approvedRejected:
{
  "Approved by": _g(.), # grey
  "Rejected by": _r(.), # red
};

def approvedRejected:
  if . == null then 
    . 
  else
    _approvedRejected[.] // . 
  end;

def filterSummaryApprovedBy:
# match 
# "Rejected by arn:aws:iam::...:user/giggsc",
# "Approved by arn:aws:iam::...:user/garyf"
  (capture("(?<action>(Approved|Rejected) by).*/(?<user>(.*))")
    | if . != null then "\(.action|approvedRejected) \(.user)" else . end)
  //.;

def getSummaryApprovedBy:
  (map(select(.actionName=="DeployToProduction")))
  | max_by(.startTime)
  | .output.executionResult.externalExecutionSummary
  | if . == null then null else filterSummaryApprovedBy end
  # | if . == null then null else "\(.action|approvedRejected) \(.user)" end
  | . // ""
  ;

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

def _hourHighlight_yellow_u:
  if   . ==  0 then  .|tostring|lp(2)|__(.)
  else
    .|tostring|lp(2)|_bgy(.)
  end;

def s_ToDuration_red_underline:
  if . == null then .
  else
    ( . / (60*60) | floor ) as $hour |
    ( (. / 60) % 60 | floor) as $min |
    (. % 60) as $sec |
    "\($hour|_hourHighlight_yellow_u|.+__(":"))\($min|_minHighlight_red|lp(2))\("."|__(.))\($sec|tostring|lp(2)|__(.))"
  end;

def getDurationToNow($pipelineStatus):
  if $pipelineStatus == "InProgress" then
    (map(.startTime) | min) as $minTime
    # aws_fromdate assumes input date is in UTC time not SG time
    # adjust now since $minTime|aws_fromdate is not in SG time
    | "\(_duration_s($minTime|aws_fromdate;now+8*60*60)|s_ToDuration_red_underline)"
    # | $minTime|aws_fromdate,
  else
    ""
  end
  ;
# get the duration of the pipeline to display in the summary header
def getSummaryHeaderDuration:
  (map(.startTime) | min) as $minTime
  | (map(.lastUpdateTime) | max) as $maxTime
  | "\(_duration_s($minTime|aws_fromdate;$maxTime|aws_fromdate)|s_ToDuration_red) \($minTime|pTimehms) \($maxTime|pTimehms)"
  ;

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

def _pstageCount:
  if   . ==  6 then .|tostring|__(.)
  else
    .|tostring|__(.)
  end;

def getSummaryMinDate:
  (map(.startTime) | min) as $minTime
  | (unique_by(.stageName) | length | _pstageCount) as $stageCount
  | "\($minTime|pTimedm) \($stageCount)"
  ;

def getExecutionHeader($pipelineStatus):
    "\(first.pipelineExecutionId|__(.)) "
    +"\(getSummaryMinDate) "
    +"\($pipelineStatus|actions_aplStatus) "
    +"     "
    +"\(getSummaryHeaderDuration) "
    +"\(getDurationToNow($pipelineStatus))"
    +"\(getSummaryApprovedBy)";
