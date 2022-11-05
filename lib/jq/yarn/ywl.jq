include "sort";

def _sortKeys:
[
"@rc-main/api",
"@rc-main/common-services",

"@rc-main/common-lib",
"@rc-main/daemons",
"@rc-main/frontend",
"@rc-main/frontend-wonka",

"@rc-main/infra",
"@rc-main/ui-lib",

"infrastructure",
"referralcandy-main",
"@rc-main/cognito-triggers",
"@rc-main/rc-authorizer"
];

# def addSortKey

def ywl: 
  addSortKey("name";_sortKeys)
  | sort_by(.sortKey, .name)
  | map(.name)
  | .[]
  ;
