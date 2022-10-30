include "pad";
include "colour";
include "colour-scale";
include "docker";

def _image:
  # truncate and highlight aws ecr prefix
  # gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"...")|_("bblue"))+(.x | _tacha(.)));
  gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"..."))+(.x));
def _repo:
 # gsub("(?<repo>.*)/(?<image>.*)";(.repo|_y(.)));
  gsub("(?<repo>.*)/(?<image>.*)" ; 
        ( "\(.repo|_g(.))"
          +"\("/"|__(.))"
          +"\(.image|_cs5)"
        )
      );

def _203image:
  gsub("(?<dkr>.*)\\.\\.\\.(?<image>.*)" ; 
        ( "\(.dkr|_("bblue"))"
          +"\("..."|__(.))"
          +"\(.image|_orange(.))"
        )
      );

def _localImage:
  gsub("(?<dkr>.*)" ; 
        ( "\(.dkr|_purple(.))"
        )
      );


def _repository:
  _image
  | lp(40)
  | _repo
  | _203image
  | _localImage
;

def _git:
  gsub("(?<git>git_)(?<hash>.*)" ; 
        ( "\(.git|_b(.))"
          +"\(.hash|_g(.))"
        )
      );

def _tag:
  rp(20) |
  if . | contains("latest") then .|_cs0
  elif . | contains("<none>") then .|__(.)
  elif . | startswith("git") then .|_git
  else
    _y(.)
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
    

def _createdAt($monthsAgo):
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

def setMonthsAgo:
  (.CreatedAt[0:10]+"T"+.CreatedAt[11:19]+"Z"| fromdate ) as $createdUnixTime 
  | (now - $createdUnixTime) as $secondsAgo 
  | ($secondsAgo/(60*60*24*30)|floor ) as $monthsAgo 
  | ._monthsAgo = $monthsAgo
;

def setSizeUnit:
  (.Size | capture("(?<unit>(MB|GB|kB))") | .unit ) as $unit
  | (.Size | capture("(?<size>([0-9\\.]*))") | .size ) as $sizeNumber
  | ._unit = $unit
  | ._size = $sizeNumber
;

def _mb:
  (. |tostring|lp(4)) as $mb |
  if . < 100 then $mb | _cs0
  elif . < 200 then $mb | _cs3
  elif . < 300 then $mb | _cs5
  elif . < 400 then $mb | _cs7
  elif . < 500 then $mb | _cs9
  elif . < 600 then $mb | _cs10
  elif . < 700 then $mb | _cs11
  elif . < 800 then $mb | _cs12
  elif . < 900 then $mb | _cs13
  else _r($mb)
  end
  ;

def _gb:
  (. |tostring|lp(4)) as $mb |
  if . < 1.5 then $mb | _cs0
  elif . < 2 then $mb | _cs3
  elif . < 2.5 then $mb | _cs5
  elif . < 3 then $mb | _cs7
  elif . < 3.5 then $mb | _cs9
  elif . < 4 then $mb | _cs10
  elif . < 4.5 then $mb | _cs11
  elif . < 5 then $mb | _cs12
  else _r($mb)
  end
  ;

def _size($size; $unit):
  if $unit == "kB" then __($size|lp(4)) + " " + _b($unit)
  elif $unit == "MB" then ($size|tonumber|floor|_mb|lp(4)) + " " + __($unit)
  elif $unit == "GB" then ($size|tonumber|_gb|lp(4)) + " " + _r($unit)
  else _r($size|lp(4)) + " " + $unit
  end
  ;

def dil:
  sort_by(.Repository)
  | map(setMonthsAgo)
  | map(setSizeUnit)
  | .[]
  | ._monthsAgo as $monthsAgo
  | ._unit as $unit
  | ._size as $size
  | " \(.ID|__(.))"
  +" \(._monthsAgo|_monthDiff)"
  +" \(.CreatedAt|_createdAt($monthsAgo))"
  +"\(.Repository|_repository)"
  +" \(.Tag|_tag)"
  +" \(_size($size;$unit))"
  # +" \(.Size)"
  # +" \(.VirtualSize)"
  ;

