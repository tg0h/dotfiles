include "pad";
include "colour";
include "colour-scale";
include "rainbow-theme";
# Name
# Arn
# State
# ScheduleExpression
# EventBusName
# EventPattern

def subName:
  sub("(?<x>refresh)";("\(_r(.x))"))
  | sub("(?<x>sql)";("\(_y(.x))"))
  | sub("(?<x>production)";("\(_orange(.x))"))
  | sub("(?<x>staging)";("\(_b(.x))"))
  # prod rules
  | sub("(?<x>onemindaemon)";("\(.x|_cs0)"))
  | sub("(?<x>fifteenminsdaemon)";("\(.x|_cs4)"))
  | sub("(?<x>onehourdaemon)";("\(.x|_cs8)"))
  | sub("(?<x>dailydaemon)";("\(.x|_cs10)"))
  | sub("(?<x>tendaydaemon)";("\(.x|_cs14)"))
  | sub("(?<x>dailyrates)";("\(.x|_rb0)"))
  | sub("(?<x>senddkimemail)";("\(.x|_rb1)"))
  | sub("(?<x>updatestats)";("\(.x|_rb2)"))
  | sub("(?<x>StagingDBUpdate)";("\(___(.x))"))
  | sub("(?<x>rule)";("\(_g_u(.x))"))
  #
  | sub("(?<x>test-)";("\(_bgy(.x))"))
;

def showName: "\(.Name | subName | lp(70)) "
;


def subScheduleExpression:
  sub("(?<x>cron)";("\(_brinkPink(.x))"))
  | sub("(?<x>minute)";("\(.x|_cs0)"))
  | sub("(?<x>minutes)";("\(.x|_cs0)"))
  | sub("(?<x>hour)";("\(.x|_cs7)"))
  | sub("(?<x>hours)";("\(.x|_cs7)"))
  | sub("(?<x>day)";("\(.x|_cs12)"))
  | sub("(?<x>days)";("\(.x|_cs12)"))
  | sub("(?<x>rate)";("\(_bt(.x))"))
;

def showScheduleExpression: 
if has("ScheduleExpression") then
  .ScheduleExpression | subScheduleExpression
else
  ""
end
;

def showEventPattern:
if has("EventPattern") then
  .EventPattern
else
  ""
end
;

def showState:
if (.State == "ENABLED") then
  _bgg(" ENABLED")
else
  _bgr("DISABLED")
end
;

def showRule:
 showName
 +showState
 +" "
 +showScheduleExpression 
 +showEventPattern
;

def ebl: 
  .Rules[]
  | showRule
;
