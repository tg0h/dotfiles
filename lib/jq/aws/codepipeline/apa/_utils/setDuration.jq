include "date";
include "aws-time";
include "aws/codepipeline/apa/config";

    def setDuration:
      ._startTime = (.startTime| aws_fromdate) | ._lastUpdateTime = (.lastUpdateTime| aws_fromdate) | ._duration = ._lastUpdateTime - ._startTime | ._prettyDuration = (._duration|s_ToDuration);
    def setRunOrder($stageName):
      if $stageName == "staging" then
        .runOrder = (_runOrderDict[.actionName][0] // 0)
      elif $stageName == "production" then
        .runOrder = (_runOrderDict[.actionName][1] // 0)
      else
        .runOrder = 1
      end;
