include "pad";
include "colour";
include "aws/loadbalancer/subSpecialAction"; # sensitive actions
include "aws/route53/subCandyUrls";
# Priority
# Conditions
# Actions
# IsDefault

def show:
.
;
def showPriority:
.
;

def mapValue:
  if (has("Value")) then
  .Value
  elif has("Values") then
  .Values | join(",")
  elif has("SourceIpConfig") then
  .SourceIpConfig.Values | join(",")
  else
  .HttpRequestMethodConfig.Values | join(",")
  end
;

def subField:
  sub("(?<x>path-pattern)";(_g("path")))
  | sub("(?<x>host-header)";(_orange("host")))
  | sub("(?<x>source-ip)";(_bt("ip")))
  | sub("(?<x>http-request-method)";(_y("method")))
;

def subOtherSpecialNames:
  sub("(?<x>partners.referralcandy.com)";("\(__u("partners.referralcandy.com"))"))
  | sub("(?<x>blog.referralcandy.com)";("\(__u("blog.referralcandy.com"))"))
  | sub("(?<x>bytes.referralcandy.com)";("\(__u("bytes.referralcandy.com"))"))
  | sub("(?<x>help.referralcandy.com)";("\(__u("help.referralcandy.com"))"))
;

def mapConditionFieldValue:
# map((.Field| subField ) + ":" + mapValue|trunc(30)) | join(",") | lp(60)
map((.Field) + ":" + mapValue|trunc(50)) | join(",") | subField | subOtherSpecialNames | subCandyUrls | lp(80)
# .Field 
;
def mapConditions:
# ._Conditions = (.Conditions | map(mapConditionFieldValue) )
._Conditions = (.Conditions | mapConditionFieldValue )
;

def mapRedirectAction:
.RedirectConfig | .StatusCode+" "+.Host+.Path
;

def mapForwardAction:
.ForwardConfig | .TargetGroups | map(.TargetGroupArn + "\(_orange("->"))"+(.Weight|tostring)) | join(",")
;

def mapFixedResponseAction:
.FixedResponseConfig | "\(.StatusCode) \(.MessageBody)"
;

def mapActionTypes:
if (.Type == "redirect") then
  .Type +" "+ mapRedirectAction
elif (.Type == "forward") then
  .Type +" "+ mapForwardAction
elif (.Type == "fixed-response") then
  .Type +" "+ mapFixedResponseAction
end
;

def subAction:
  sub("(?<x>redirect)";(_g("redir")))
  | sub("(?<x>forward)";(_bgy("forwd")))
  | sub("(?<x>fixed-response)";(__("fixed")))
  | sub("(?<x>HTTP_301)";(_gold("301")))
  | sub("(?<x>403)";(_r("403")))
  | sub("(?<x>production)";(_g(.x)))
  | sub("(?<x>referralcorner)";(_tacha(.x)))
  | sub("(?<x>folp)";(_bt(.x)))
  | sub("(?<x>frontend)";(_brinkPink(.x)))
  | sub("(?<x>external-api)";(_mg(.x)))
  | sub("(?<x>api)";(_purple(.x)))
  | sub("(?<x>bigcommerce)";(_yaleBlue_b(.x) ))
  | sub("(?<x>referralcandy.com)";(_sdb(.x) ))
  | sub("(?<x>notfound)";(_r(.x) ))
;

def mapActions:
._Actions = (.Actions[] | mapActionTypes | subAction | subSpecialAction | subCandyUrls)
;

def mapRules:
mapConditions
| mapActions
;

def subPriority:
  sub("(?<x>default)";(_g("DEF")))
;

def showRules:
" \(._Conditions)"
+" \(___(.Priority|subPriority) | lp(3)) "
+"\(._Actions)"
;

def albr:
.Rules
# | map(select(.Priority == "450"))
| .[]
| mapRules
| showRules

;
