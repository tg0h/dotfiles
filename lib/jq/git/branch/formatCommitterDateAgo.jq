include "pad";
include "colour";
include "colour-out";
include "decoration";
include "colour-scale";
include "rainbow-theme";
include "grey-scale";
include "time-format";

def formatUnit: {
  "s": "s"|_gs0,
  "m": "m"|_cs0,
  "h": "h"|_gs7,
  "D": "D"|_rb8,
  "W": ("W")|_cs5,
  "M": ("M")|_rb0
};

def formatDuration($secs):
  (.|tostring) as $duration
  | 
    if $secs < 60 * MIN then  $duration|_freeSpeechGreen(.)
    # elif $secs < 3 * HOUR  then $duration|_rb10
    # elif $secs < 6 * HOUR then $duration|_rb10
    # elif $secs < 9 * HOUR then $duration|_rb9
    elif $secs < 12 * HOUR then $duration|_cs0

    elif $secs < 1 * DAY then $duration|_cs1
    elif $secs < 2 * DAY then $duration|_cs2
    elif $secs < 3 * DAY then $duration|_cs3

    elif $secs < 1 * WEEK then $duration|_cs4
    # elif $secs < 1.5 * WEEK then $duration|_cs6
    elif $secs < 2 * WEEK then $duration|_cs5

    elif $secs < 3 * WEEK then $duration|_cs6
    elif $secs < 1 * MONTH then $duration|_cs7

    elif $secs < 2 * MONTH then $duration|_cs10
    elif $secs < 3 * MONTH then $duration|_cs15
    else 
      # ($duration|_bgr(.))
      $duration|_cs15|rv
    end
;

# [<duration>, <unit>, <normalized duration (in s)>]
def formatCommitterDateAgo($secondsHumanFormat):
    $secondsHumanFormat[0] as $duration
    | $secondsHumanFormat[1] as $unit
    | $secondsHumanFormat[2] as $secs
    | ($duration | formatDuration($secs)) as $formatDuration
    | formatUnit[$unit] as $formatUnit
    | [$formatDuration, $formatUnit, $secs]
;
