include "pad";
include "colour";
include "colour-scale";
include "aws-time";
include "date";



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

