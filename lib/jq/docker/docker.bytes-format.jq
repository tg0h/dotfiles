include "pad";
include "colour";
include "colour-scale";

def _mb:
  (. |tostring|lp(4)) as $mb |
  if . < 100 then $mb | _cs0
  # elif . < 200 then $mb | _cs3
  elif . < 350 then $mb | _cs1
  # elif . < 400 then $mb | _cs7
  # elif . < 500 then $mb | _cs9
  elif . < 700 then $mb | _cs2
  # elif . < 700 then $mb | _cs11
  # elif . < 800 then $mb | _cs12
  # elif . < 900 then $mb | _cs3
  else $mb | _cs3
  end
  ;

def _gb:
  (. |tostring|lp(4)) as $mb |
  if . < 1.5 then $mb | _cs4
  elif . < 2 then $mb | _cs5
  elif . < 2.5 then $mb | _cs6
  elif . < 3 then $mb | _cs7
  elif . < 3.5 then $mb | _cs9
  elif . < 4 then $mb | _cs10
  elif . < 4.5 then $mb | _cs11
  elif . < 5 then $mb | _cs12
  else _r($mb)
  end
  ;

def DockerBytesFormat($size; $unit; $padding):
  if $unit == "kB" then __($size|lp($padding)) +" "+ colour($unit|tostring;"ebony")
  elif $unit == "MB" then ($size|tonumber|floor|_mb) +" "+ colour($unit|tostring;"ebony")
  elif $unit == "GB" then ($size|tonumber|_gb) +" "+ __($unit)
  else _r($size) + " " + $unit
  end
  ;
