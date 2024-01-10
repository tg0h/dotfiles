include "pad";
include "aws-time";
include "aws/route53/subCandyUrls";
include "colour";
include "colour-scale";
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

def subOthers:
  sub("(?<x>influencercandy)";("\(__(.x))"))
;

def subJunk:
  sub("(?<x>miguelg)";("\(_bgy(.x))"))
  # | sub("(?<x>influencercandy)";("\(_bgy(.x))"))
;

def subCandy:
  sub("(?<x>frontend)";("\(_brinkPink(.x))"))
  | sub("(?<x>production)";("\(_v(.x; "gold"))"))
  # | sub("(?<x>wonka)";("\(_m(.x))"))
  # | sub("(?<x>wonk)";("\(_m(.x))"))
  | sub("(?<x>ref-corner)";("\(.x|_cs0)"))
  | sub("(?<x>maintenance)";("\(.x | _cs7)"))
  | sub("(?<x>-assets)";("\(_y(.x))"))
;

def subName:
  subCandy
  | subCandyUrls 
  | subJunk 
  | subOthers
;

def showDistribution:
"\(.Id | lp(14))"
+" \(.DomainName | trunc(30) | lp(30))"
+" \(._Aliases | trunc(50) | lp(50) | subName)"
+" \(._Origins | trunc(50) | rp(50) | subName)"
+" \(.Comment | trunc(50) | rp(50))"
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
