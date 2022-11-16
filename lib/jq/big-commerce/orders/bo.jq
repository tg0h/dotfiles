include "colour";
include "pad";

# Wed, 09 Nov 2022 06:58:24 +0000
def _isDeleted: if . == true then _r("D") else __("D") end;

def _orderStatus:
{
  "Incomplete": _y("Incomplete"), 
  "Pending": _y("Pending"), 
  "Shipped": _g("Shipped"), 
  "Partially Shipped": _g("Partially Shipped"), 
  "Refunded": _r("Refunded"), 
  "Cancelled": _r("Cancelled"), 
  "Declined": _r("Declined"), 
  "Awaiting Payment": _y("Awaiting Payment"), 
  "Awaiting Pickup": _y("Awaiting Pickup"), 
  "Awaiting Shipment": _g("Awaiting Shipment"), 
  "Completed": _g("Completed"), 
  "Awaiting Fulfillment": _g("Awaiting Fulfillment"), 
  "Manual Verification Required": _y("Manual Verification Required"), 
  "Disputed": _r("Disputed"), 
  "Partially Refunded": _r("Partially Refunded"), 
};

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

def convertModDate:
  .[17:19] as $hour | .[20:22] as $min | .[23:25] as $sec | "\(_y($hour))" +__(":") +"\(__($min))" +__(".") +"\(__($sec))";

def mapOrder:
  "\(.id) "
  +"\(__(.status_id|tostring)) "
  +"\(_orderStatus[(.status)]) "
  +"\(.date_created|convertDate) "
  +"\(.date_modified|convertModDate) "
  # +"\(.coupons) "
  +"\(_m(.customer_locale)) "
  +"\(_g(.currency_code)) "
  +"\(.is_deleted|_isDeleted) "
  +"\(__(.ip_address))"
  # +"\(.external_id) "
  # +"\(.custom_status) "
  # +"\(.geoip_country) "
;

def bo: 
  # .
  map(mapOrder)
  | .[]
  ;

