def printFunction:
.FunctionName;

def al:
  .Functions 
  | sort
  | map(printFunction)
  | .[]
  ;
