
def SetKbSize:
  ._unit as $unit
  | ._size as $sizeNumber
  |
  if $unit == "kB" then ._sizeKb = ($sizeNumber|tonumber)
  elif $unit == "MB" then ._sizeKb = ($sizeNumber|tonumber)*1000
  elif $unit == "GB" then ._sizeKb = ($sizeNumber|tonumber)*1000*1000
  else .
  end
;

def SetUnitSize:
  (.Size | capture("(?<unit>(MB|GB|kB))") | .unit ) as $unit
  | (.Size | capture("(?<size>([0-9\\.]*))") | .size ) as $sizeNumber
  | ._unit = $unit
  | ._size = $sizeNumber
;
