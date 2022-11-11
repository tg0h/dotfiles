include "colour";
include "pad";

# Wed, 09 Nov 2022 06:58:24 +0000
def _isEnabled: if . == true then _g("E") else _r("E") end;

def convertDate:
  .[5:7] as $day |
  .[8:11] as $month |
  .[12:16] as $year |
  .[17:19] as $hour |
  .[20:22] as $min |
  .[23:25] as $sec |
  .[26:31] as $tz |
  "\(__($year[2:4]))"
  +__("/")
  +"\(__($month))"
  +__("/")
  +"\(_bt($day))"
  +" "
  +"\(_y($hour))"
  +__(":")
  +"\(__($min))"
  +__(".")
  +"\(__($sec))"
  +"\(__($tz))"
  ;

def mapCoupon:
  "\(__(.id|tostring)) "
  +"\(.date_created|convertDate) "
  +"\(__(.name)) "
  +"\(_brinkPink(.code)) "
  +"\(_g(.amount|tostring)) "
  +"\(__(.type)) "
  +"\(__(.num_uses|tostring)) "
  +__("$>=")+"\(__(.min_purchase)) "
  +__("#<=")+"\(__(.max_uses|tostring)) "
  +__("#/p<=")+"\(__(.max_uses_per_customer|tostring)) "
  +"\(.enabled|_isEnabled) "
  +"\(.expires) "
;

def bac: 
  # .
  map(mapCoupon)
  | .[]
  ;

