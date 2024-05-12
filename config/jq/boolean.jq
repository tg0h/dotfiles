include "colour";

def bool($bool): ($bool|tostring) | if . == "true" then _g("X") else __("-") end;

def bool($bool; $trueString): ($bool|tostring) | if . == "true" then _g($trueString) else __("-") end;
