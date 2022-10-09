def getMaxStartTimeArray:
  (map(select(.runOrder == 1) | .startTime) | max) as $maxStartTime1
  | (map(select(.runOrder == 2) | .startTime) | max) as $maxStartTime2
  | (map(select(.runOrder == 3) | .startTime) | max) as $maxStartTime3
  | (map(select(.runOrder == 4) | .startTime) | max) as $maxStartTime4
  | (map(select(.runOrder == 5) | .startTime) | max) as $maxStartTime5
  | ([ $maxStartTime1, $maxStartTime2, $maxStartTime3, $maxStartTime4, $maxStartTime5 ]);

