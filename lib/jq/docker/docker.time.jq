include "pad";
include "colour";
include "colour-scale";

def setMonthsAgo:
  (.CreatedAt[0:10]+"T"+.CreatedAt[11:19]+"Z"| fromdate ) as $createdUnixTime 
  | (now - $createdUnixTime) as $secondsAgo 
  | ($secondsAgo/(60*60*24*30)|floor ) as $monthsAgo 
  | ._monthsAgo = $monthsAgo
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

def _yearDiff($year):
  ($year|tostring|.[2:4] ) as $yy |
  if . == 0 then $yy|_cs0
  elif . == 1 then $yy|_cs3
  elif . == 2 then $yy|_cs5
  elif . == 3 then $yy|_cs7
  elif . == 4 then $yy|_cs9
  elif . == 5 then $yy|_cs10
  elif . == 6 then $yy|_cs11
  elif . == 7 then $yy|_cs12
  elif . == 8 then $yy|_cs13
  elif . == 9 then $yy|_cs14
  elif . == 10 then $yy|_cs15
  else _r(.)
  end
  ;
    
def _year:
  . as $year |
  (now|localtime | .[0]) as $currentYear |
  ($currentYear - .) | _yearDiff($year) | tostring
;

def _day($monthsAgo):
  if $monthsAgo == 0 then .|_cs0
  elif $monthsAgo == 1 then .|_cs3 
  else __(.) 
  end
  ;

def _month($monthsAgo):
  if $monthsAgo == 0 then .|_cs0
  elif $monthsAgo == 1 then .|_cs3 
  elif $monthsAgo == 2 then .|_cs6
  elif $monthsAgo == 3 then .|_cs9
  else __(.) 
  end
  ;

def FormatCreatedAtTime($monthsAgo):
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\($year | tonumber | _year | __(.))"
  +"\("/"| __(.))"
  +"\(($month) | _month($monthsAgo))"
  +"\("/"| __(.))"
  +"\(($day) | _day($monthsAgo))"
  +" "
  +"\($hour | __(.))"
  +"\(__(":"))"
  +"\(($min) | __(.))"
  ;
