# like numfmt for time
# converts seconds to human readable time duration
# eg 1000 to [1, M]

include "math";

def MIN: 60;
def HOUR: 60*MIN;
def DAY: 24*HOUR;
def WEEK: 7*DAY;
def MONTH: 30*DAY;
def YEAR: 12*MONTH;


# like numfmt
# takes seconds and returns { time: <t>, unit: <u>}
# $format is the minimum unit wanted
# - m - minutes
# - h - hours
# - D - Days
# - W - Weeks
# - M - Months

# def _sizeToIec:
#   1000 as $kbInB
#   | (1000 * 1000) as $mbInB
#   | (1000 * 1000 * 1000 ) as $gbInB
#   | if . < $mbInB then (. / $kbInB | round | tostring)
#   elif . < $gbInB then (. / $mbInB | round | tostring)
#   else (. / $gbInB | _roundTo2Dp | tostring)
#   end;


# convert seconds to [ number, unit ]
# where unit is
# s - seconds
# m - minutes
# h - hours
# D - days
# W - weeks
# M - months
def TimeFormat($minimumUnit):
  (if $minimumUnit == "s" then
    if . < MIN then [ . , "s", . ]
    elif . < HOUR then [ . / MIN , "m" ]
    elif . < DAY then [ . / HOUR , "h" ]
    elif . < WEEK then [ . / DAY , "D" ]
    elif . < MONTH then [ . / WEEK , "W" ]
    else [ . / MONTH , "M" ]
    end
  elif $minimumUnit == "m" then
    if . < MIN then [ . / MIN , "m" ]
    elif . < HOUR then [ . / MIN , "m" ]
    elif . < DAY then [ . / HOUR , "h" ]
    elif . < WEEK then [ . / DAY , "D" ]
    elif . < MONTH then [ . / WEEK , "W" ]
    else [ . / MONTH , "M" ]
    end
  elif $minimumUnit == "h" then
    if . < DAY then [ . / HOUR , "h" ]
    elif . < WEEK then [ . / DAY , "D" ]
    elif . < MONTH then [ . / WEEK , "W" ]
    else [ . / MONTH , "M" ]
    end
  elif $minimumUnit == "D" then
    if . < WEEK then [ . / DAY , "D" ]
    elif . < MONTH then [ . / WEEK , "W" ]
    else [ . / MONTH , "M" ]
    end
  elif $minimumUnit == "W" then
    if . < MONTH then [ . / WEEK , "W" ]
    else [ . / MONTH , "M" ]
    end
  elif $minimumUnit == "M" then
    [ . / MONTH , "M" ]
  else
    [ . / MONTH , "M" ]
  end) as $tuple
  | $tuple + [ . ] 
  ;

# accepts [ number, unit ]
# and rounds number
def RoundHumanTime:
  .[0] as $number
  | .[1] as $unit
  | 
    if $unit == "s" then $number
    elif $unit == "m" then $number | RoundTo(1)
    elif $unit == "h" then $number | RoundTo(1)
    elif $unit == "D" then $number | RoundTo(1)
    elif $unit == "W" then $number | RoundTo(1)
    elif $unit == "M" then $number | RoundTo(1)
    else $number | RoundTo(1)
    end
  ;

# default TimeFormat without arg, use $m (minutes)
def TimeFormat: "s" as $minimumUnit | TimeFormat($minimumUnit);
