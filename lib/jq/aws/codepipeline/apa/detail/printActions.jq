include "aws-time";
include "aws-pipeline";
include "pad";
include "colour";
include "aws/codepipeline/apa/detail/printExecutionResult";


def durationHighlight:
  if (.maxDuration//0 > 0) then
    .maxDuration | tostring | lp(5) | _r(.)
  else
    ._duration | tostring | lp(5) | __(.)
  end;

def __actionExecutionStatus:
{
  "Succeeded": _g("S"), # green_bg
  "Failed": _bgr("F"),
  "InProgress": _y("P"),
};
def _actionExecutionStatus:
  __actionExecutionStatus[.] // .;

def printActionName($stageName):
  if $stageName == "staging" or $stageName == "production" then
    _stgProdActionName
  else
    __(.)
  end;

def printRunOrder($stageName):
  if $stageName == "staging" or $stageName == "production" then
    _runOrder($stageName) # use the aws-pipeline _runOrder printer
  else
    .
  end;

def printActions($stageName; $maxarray):
  "  \(.runOrder | printRunOrder($stageName)) "
  +"\(.actionName| rp(40) |printActionName($stageName) ) "
  +"\(.status|_actionExecutionStatus) "
  +"\(durationHighlight) "
  +"\(._prettyDuration) "
  +"\(.startTime|pTimehms) "
  +"\(.lastUpdateTime|pTimehms) "
  +"\(printExecutionResult)"
  ;
