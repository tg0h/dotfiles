include "colour";

def _couponTypes:
{
  "0": __("per_item_discount"), 
  "1": __("percentage_discount"), 
  "2": __("per_total_discount"), 
  "3": __("shipping_discount"), 
  "4": __("free_shipping"), 
  "5": __("promotion"), 
};

def mapCoupon:
  "\(__(.id|tostring)) "
  +"\(.order_id) "
  +"\(.coupon_id) "
  +"\(_brinkPink(.code)) "
  +"\(_g(.amount|tostring)) "
  +"\(__(.type|tostring)) "
  +"\(_couponTypes[.type|tostring]) "
  # +"\(.discount) "
;

def boc: 
  map(mapCoupon)
  | .[]
  ;
