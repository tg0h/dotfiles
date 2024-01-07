include "pad";

def showSecurityGroups:
  if (has("SecurityGroups")) then
   .SecurityGroups | join(",")
  else
   ""
  end
;

def showAvailabilityZones:
  if (has("AvailabilityZones")) then
   .AvailabilityZones | map(.ZoneName) | join(",")
  else
   ""
  end
;

def showLoadBalancer:
"\(.LoadBalancerName | lp(45))"
# + "\(.DNSName | lp(80))"
+ " \(.Scheme | lp(15))"
+ " \(.VpcId | lp(10))"
+ (showSecurityGroups | lp(11))
+ " " 
# +showAvailabilityZones
+ "\(.LoadBalancerArn)"
;

def loadBalancers:
.
;
def alb:
  .LoadBalancers
  | sort_by(.LoadBalancerName)
  | .[]
  | showLoadBalancer
;
