include "pad";
include "colour";
include "colour-scale";

def setCreatedMinutesAgo:
  (.Created[0:10]+"T"+.Created[11:19]+"Z"| fromdate ) as $createdUnixTime 
  | (now - $createdUnixTime) as $secondsAgo 
  | ($secondsAgo/(60)|floor ) as $minutesAgo 
  | ._createdMinutesAgo = $minutesAgo
;

def _monthDiff:
  (. |tostring|lp(2)) as $month |
  if . == 0 then $month | _cs0
  elif . == 1 then $month | _cs3
  elif . == 2 then $month | _cs5
  elif . == 3 then $month | _cs7
  elif . == 4 then $month | _cs9
  elif . == 5 then $month | _cs10
  elif . == 6 then $month | _cs11
  elif . == 7 then $month | _cs12
  elif . == 8 then $month | _cs13
  elif . == 9 then $month | _cs14
  elif . == 10 then $month | _cs15
  else _r($month)
  end
  ;

def _day($monthsAgo):
  if $monthsAgo == 0 then .|_cs0
  elif $monthsAgo == 1 then .|_cs3 
  else __(.) 
  end
  ;

def _highlight($minutesAgo):
  ($minutesAgo / 60 ) as $hoursAgo |
  if $minutesAgo < 5 then .| _cs0
  elif $minutesAgo < 30 then .| _cs1
  elif $hoursAgo < 1 then .|_cs2
  elif $hoursAgo < 2 then .|_cs3
  elif $hoursAgo < 3 then .|_cs4
  elif $hoursAgo < 4 then .|_cs5
  elif $hoursAgo < 5 then .|_cs6
  elif $hoursAgo < 6 then .|_cs7
  elif $hoursAgo < 7 then .|_cs8
  elif $hoursAgo < 8 then .|_cs9
  else .|_cs15
  end
  ;

def isoUTCtoSG:
 (.[0:10]+"T"+.[11:19]+"Z"| fromdate ) as $createdUnixTime 
 | ($createdUnixTime + 8*60*60)
 | todate
 ;

def FormatTime($minutesAgo):
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\($year | __(.))"
  +"\("/"| __(.))"
  +"\(($month) | __(.))"
  +"\("/"| __(.))"
  +"\(($day) | _day($minutesAgo))"
  +" "
  +"\($hour | _highlight($minutesAgo))"
  +"\(__(":"))"
  +"\(($min) | _highlight($minutesAgo))"
  ;

def _FormatTimeFinishedAt:
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\($year | __(.))"
  +"\("/"| __(.))"
  +"\(($month) | __(.))"
  +"\("/"| __(.))"
  +"\(($day) | __(.))"
  +" "
  +"\($hour | __(.))"
  +"\(__(":"))"
  +"\(($min) | __(.))"
  ;
