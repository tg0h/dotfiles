include "pad";
include "colour";
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

# hardcode the run order to display in list pipeline actions
# TODO: get the run order from aws codepipeline get-pipeline instead
def _runOrderDict:
# the run order for [<staging>, <production>] is stored in an array
{ 
  ## Tests
  "Tests": [5, 99],
  ## Deploy
  "DeployToProduction": [99, 1],

  ## AUTH
  "cognito.Prepare": [1, 2],
  "cognito.Deploy": [2, 3],
  "cognito-wonka.Prepare": [1, 2],
  "cognito-wonka.Deploy": [2, 3],

  ## FRONTEND
  "frontend.Prepare": [1, 2],
  "frontend.Deploy": [2, 3],
  "frontend-wonka.Prepare": [1, 2],
  "frontend-wonka.Deploy": [2, 3],
  "storybook.Prepare": [1, 2],
  "storybook.Deploy": [2, 3],

  ## BACKEND
  "api.Prepare": [3, 4],
  "api.Deploy": [4, 5],
  "api-nerfed.Prepare": [3, 4],
  "api-nerfed.Deploy": [4, 5],
  "apiInternal.Prepare": [1, 2],
  "apiInternal.Deploy": [2, 3],

  ## DB
  "dynamoDBStack.Prepare": [1, 2],
  "dynamoDBStack.Deploy": [2, 3],

  ## AWS
  "s3Stack.Prepare": [1, 2],
  "s3Stack.Deploy": [2, 3],
  "sendDkimEmail.Prepare": [1, 2],
  "sendDkimEmail.Deploy": [2, 3],
  "sqsQueueStack.Prepare": [1, 2],
  "sqsQueueStack.Deploy": [2, 3],

  ## DAEMONS?
  "createDailyRate.Prepare": [1, 2],
  "createDailyRate.Deploy": [2, 3],
  "updateReferral.Prepare": [1, 2],
  "updateReferral.Deploy": [2, 3],
  "createDaemonDailyScheduler.Prepare": [3, 4],
  "createDaemonDailyScheduler.Deploy": [4, 5],
  "createDaemonFifteenMinsScheduler.Prepare": [3, 4],
  "createDaemonFifteenMinsScheduler.Deploy": [4, 5],
  "createDaemonTenDayScheduler.Prepare": [3, 4],
  "createDaemonTenDayScheduler.Deploy": [4, 5],
  "updateStat.Prepare": [3, 4],
  "updateStat.Deploy": [4, 5]
};

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
