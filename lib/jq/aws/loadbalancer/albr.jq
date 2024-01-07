include "pad";
include "colour";
include "aws/loadbalancer/subAction";
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

def mapConditionFieldValue:
# map((.Field| subField ) + ":" + mapValue|trunc(30)) | join(",") | lp(60)
map((.Field) + ":" + mapValue|trunc(130)) | join(",") | subField | lp(150)
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
.ForwardConfig | .TargetGroups | map(.TargetGroupArn + "->"+(.Weight|tostring)) | join(",")
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

def mapActions:
._Actions = (.Actions[] | mapActionTypes | subAction)
;

def mapRules:
mapConditions
| mapActions
;

def showRules:
"\(.Priority | lp(7)) \(._Conditions) \(._Actions)"
;

def albr:
.Rules
# | map(select(.Priority == "450"))
| .[]
| mapRules
| showRules

;
