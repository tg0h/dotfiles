include "colour";
include "aws-time";
include "pad";

def processPerson:
"\(.person.email|__(.))";

def processEventProperties:
  .event_properties as $props |
  .event_name as $name |
  if $name == "Ordered Product" then
    "\($props.Name)" 
  elif $name == "Placed Order" or $name == "Checkout Started" then
    "\($props.Items | join(","))" 
  else
    null
  end;

def processEvent:
  "\(.datetime|pTimedmyhms) \(.event_name|rp(20)|_g(.)) \((. | processEventProperties//"")|rp(25))";
def processData:
  processEvent + processPerson
  ; 
def kpm:
  .count as $count |
  .data | map( processData)[]
  ;
