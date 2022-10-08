include "pad";
include "colour";
include "colour-scale";

# expects string input of 2022-07-21T20:07:47+08:00
# outputs 21/07 20:07

def pTime:
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\(($day) | _bt(.))\("/"+($month) | __(.)) \($hour)\((":")+($min) | __(.))";

def pTimedm:
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\(($day) | _orange(.))\("/"+($month) | __(.))";

def pTimehms:
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\( $hour|__(.) )\((":")+($min) | _bt(.)).\( $sec|__(.) )";

def pTimehms_y:
  if . == null then .
  else
    .[0:4] as $year |
    .[5:7] as $month |
    .[8:10] as $day |
    .[11:13] as $hour |
    .[14:16] as $min |
    .[17:19] as $sec |
    "\( $hour|__(.) )\((":")+($min|_y(.))).\( $sec|__(.) )"
  end;

def pTimehms_g:
  if . == null then .
  else
    .[0:4] as $year |
    .[5:7] as $month |
    .[8:10] as $day |
    .[11:13] as $hour |
    .[14:16] as $min |
    .[17:19] as $sec |
    "\( $hour|__(.) )\((":")+($min|_g(.))).\( $sec|__(.) )"
  end;

def pTimem:
  if . == null then .
  else
    .[0:4] as $year |
    .[5:7] as $month |
    .[8:10] as $day |
    .[11:13] as $hour |
    .[14:16] as $min |
    .[17:19] as $sec |
    "\($min)"
  end;


def _minHighlight:
  if   . ==  0 then   .|tostring|lp(2)|__(.)
  elif . ==  1 then   .|tostring|lp(2)|_cs0
  elif . ==  2 then   .|tostring|lp(2)|_cs3
  elif . ==  3 then   .|tostring|lp(2)|_cs5
  elif . ==  4 then   .|tostring|lp(2)|_cs7
  elif . ==  5 then   .|tostring|lp(2)|_cs9
  elif . ==  6 then   .|tostring|lp(2)|_cs10
  elif . ==  7 then   .|tostring|lp(2)|_cs11
  elif . ==  8 then   .|tostring|lp(2)|_cs12
  elif . ==  9 then   .|tostring|lp(2)|_cs13
  elif . == 10 then   .|tostring|lp(2)|_cs15
  else
    .|tostring|_bgr(.)
  end;
def _hourHighlight:
  if   . ==  0 then  .|tostring|lp(2)|__(.)
  else
    .|tostring|lp(2)|_bgr(.)
  end;

def s_ToDuration:
  if . == null then .
  else
    ( . / (60*60) | floor ) as $hour |
    ( (. / 60) % 60 | floor) as $min |
    (. % 60) as $sec |
    "\($hour|_hourHighlight|.+__(":"))\($min|_minHighlight|lp(2))\("."|__(.))\($sec|tostring|lp(2)|__(.))"
  end;
