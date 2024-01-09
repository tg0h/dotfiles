include "pad";
include "aws-time";
# Id
# ARN
# Status
# Enabled
# Staging
# LastModifiedTime
# DomainName
# Aliases

# - Origins
#    - Items
#       - DomainName
#       - CustomOriginConfig?
#       - 
# - DefaultCacheBehaviour
# - CacheBehaviours
#    - Items
#       - PathPattern
#       - TargetOriginId
#       - LambdaFunctionAssociatns

def showDistribution:
"\(.Id | lp(14))"
+" \(.DomainName | trunc(30) | lp(30))"
+" \(._Aliases | trunc(50) | lp(50))"
+" \(._Origins | trunc(50) | rp(50))"
+" \(.Comment | trunc(40) | rp(40))"
+" \(.Enabled | trunc(10) | lp(10))"
# +" \(.Status | trunc(10) | lp(10))"
# +" \(.Staging | trunc(10) | lp(10))"
+" \(.LastModifiedTime | pTimedmyhm)"
# .
;

def mapOrigins:
if has("Origins") then
  # ._Origins = (.Origins | .Items | map({DomainName: .DomainName}))
  ._Origins = (.Origins | .Items | map(.DomainName) | join(",") )
end
;

def mapAliases:
if has("Aliases") then
  ._Aliases = (.Aliases | .Items // [] | join(",") )
end
;

def mapCacheBehaviours:
if has("CacheBehaviors") then
  if ( .CacheBehaviors | .Quantity == 0) then
    .
  else
  # ._CacheBehaviours = (.CacheBehaviours | .Items // [] | join(",") )
  ._CacheBehaviours = (.CacheBehaviors | .Items | map(.PathPattern) | join(",") )
  end
end
;

def mapDistribution:
mapOrigins
| mapAliases
| mapCacheBehaviours
# .
;

def cr:
  .DistributionList
  | .Items[]
  | mapDistribution
  | showDistribution
;
