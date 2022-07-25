include "pad";
include "colour";

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
