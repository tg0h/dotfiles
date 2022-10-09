
    def setMaxDuration(stagename;maxarray):
      if .runOrder == 1 and ._duration == maxarray[0] then 
        .maxDuration = ._duration
      elif .runOrder == 2 and ._duration == maxarray[1] then 
        .maxDuration = ._duration
      elif .runOrder == 3 and ._duration == maxarray[2] then 
        .maxDuration = ._duration
      elif .runOrder == 4 and ._duration == maxarray[3] then 
        .maxDuration = ._duration
      elif .runOrder == 5 and ._duration == maxarray[4] then 
        .maxDuration = ._duration
      else
        .
      end;

def getMaxArray:
  (map(select(.runOrder == 1) | ._duration) | max) as $max1
  | (map(select(.runOrder == 2) | ._duration) | max) as $max2
  | (map(select(.runOrder == 3) | ._duration) | max) as $max3
  | (map(select(.runOrder == 4) | ._duration) | max) as $max4
  | (map(select(.runOrder == 5) | ._duration) | max) as $max5
  | ([ $max1, $max2, $max3, $max4, $max5 ]);

