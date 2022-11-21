include "date";
include "time-format";
include "colour";
include "grey-scale";
include "colour-scale";
include "rainbow-theme";

def formatYear($secondsAgo):
  ($secondsAgo / (1*YEAR)) as $diff
  | if $diff < 1 then __(.)
    else
      .|_cs10
    end
;

# use length as absolute func
def formatMonth($secondsAgo):
  ($secondsAgo / (1*DAY)) as $diff
  | 
    if $diff < 30 then __(.)
    elif $diff < 90 then __(.)
    else
      .|_cs10
    end
;

# use length as absolute func
def formatDay($secondsAgo):
  ($secondsAgo / (1*DAY)) as $diff
  | 
    if $diff < 1 then .|_cs0
    elif $diff < 2 then .  | _cs1
    elif $diff < 3 then .  | _cs2
    elif $diff < 4 then .  | _cs3
    elif $diff < 5 then .  | _cs4
    elif $diff < 6 then .  | _cs5
    elif $diff < 7 then .  | _cs6
    elif $diff < 11 then . | _cs7
    elif $diff < 15 then . | _cs8
    elif $diff < 90 then . | _cs9
    else
      .|_cs10
    end
;

def formatHour($secondsAgo):
  ($secondsAgo / HOUR) as $diff
  | 
    if $diff < 1 then .|_cs0
    elif $diff < 2 then .  | _cs1
    elif $diff < 3 then .  | _cs2
    elif $diff < 4 then .  | _cs3
    elif $diff < 5 then .  | _cs4
    elif $diff < 6 then .  | _cs5
    elif $diff < 7 then .  | _cs6
    elif $diff < 8 then .  | _cs7
    elif $diff < 9 then .  | _cs8
    elif $diff < 13 then . | _cs9
    else
      __(.)
    end
;

def formatMinute($secondsAgo):
  ($secondsAgo / HOUR) as $diff
  |
    if $diff < 1 then .|_cs0
    elif $diff < 2 then .  | _cs1
    elif $diff < 3 then .  | _cs2
    elif $diff < 4 then .  | _cs3
    elif $diff < 5 then .  | _cs4
    elif $diff < 6 then .  | _cs5
    elif $diff < 7 then .  | _cs6
    elif $diff < 8 then .  | _cs7
    elif $diff < 9 then .  | _cs8
    elif $diff < 13 then . | _cs9
    else
      __(.)
    end
;

def formatCommitterDate($committerDateObject;$committerDateFormatObject;$secondsAgo):
  $committerDateFormatObject.year as $year
  | $committerDateFormatObject.month as $month
  | $committerDateFormatObject.day as $day
  | $committerDateFormatObject.hour as $hour
  | $committerDateFormatObject.minute as $minute
  | "\($year | formatYear($secondsAgo))"
      +__("-")
      +"\($month | formatMonth($secondsAgo))"
      +__("-")
      +"\($day | formatDay($secondsAgo))"
      +" "
      +"\($hour| formatHour($secondsAgo))"
      +__(":")
      +"\($minute | formatMinute($secondsAgo))"
;
