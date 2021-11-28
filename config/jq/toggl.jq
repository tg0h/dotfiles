include "pad";

# milliseconds in an hour
def MS_HOUR: 3600000;
def MS_MIN: 60000;

# toggl hours minutes
def thm:
 (. / MS_HOUR | floor | tostring) as $hours | (. % MS_HOUR / MS_MIN | floor | tostring) as $mins | "\($hours | lp(2)) \($mins | lp(2))" ;

# toggle date
def tdate:
 .[5:10] as $date | .[11:16] as $time | "\($date) \($time)" ;
  

