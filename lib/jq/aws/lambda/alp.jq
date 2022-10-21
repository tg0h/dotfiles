include "pad";

def printPolicy:
"\(.Sid|rp(80))"
+"\(.Action)";

def alp:
  .Policy 
  | fromjson
  | .Statement
  | map(printPolicy)
  | .[]
  ;
