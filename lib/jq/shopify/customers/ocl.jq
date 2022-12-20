include "colour";
include "pad";

def formatCustomer:
  "\(.created_at)"
  +" "
  +"\(.email | lp(25) | _g(.))"
  +" "
  +"\(.first_name | lp(10) | __(.))"
  +" "
  +"\(.last_name | lp(10) | __(.))"
  +" "
  # +"\(.admin_graphql_api_id)"
  # +" "
  +"\(.id)"
  +" "
  +"\(.accepts_marketing)"
  +" "
  +"\(.currency)"
;

def ocl:
  .[]
  | .customers
  | map(formatCustomer)
  | .[]
;
