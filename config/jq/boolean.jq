include "colour";

def bool($bool): ($bool|tostring) | if . == "true" then _g("X") else __("-") end;
