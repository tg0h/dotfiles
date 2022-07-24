include "pad";
include "colour";

def prettyExit:
if (. | length==1) and (. | contains("0")) then "  "+_g(.) 
elif (. | length==1) then "  "+_y(.) 
elif (. | length==2) then " "+_y(.)
else _y(.) end;

def captureExitCode:
  capture("(?<exitCode>([0-9]{1,3}))") | .exitCode ;

def captureTimeAgoAfterExitCode:
  capture("\\) (?<timeAgo>.*)") | .timeAgo[0:6];

# Up About a minute
# Up About an hour
def captureAboutTimeAfterUp:
  capture("Up About (a|an) (?<timeUp>((\\w)*))") | .timeUp;

# Up 4 minutes
# Up 5 seconds
# Up About a minute :|
# Up About an hour
# if capturing group does not capture, pass through input
# .timeUp? - optionally index object
# if null, pass through with //
# capture returns an object with the capture group, HOWEVER if the regex does not match
# the input is EATEN
# this means you lose data if you use capture carelessly :|
def captureTimeAfterUp:
  (capture("Up (?<timeUp>((\\d)+ (\\w)*))") // .) | .timeUp?[0:6] // (. | captureAboutTimeAfterUp | "~1 "+.[0:3]) ;


def pCreatedAt:
  .[0:4] as $year |
  .[5:7] as $month |
  .[8:10] as $day |
  .[11:13] as $hour |
  .[14:16] as $min |
  .[17:19] as $sec |
  "\(($day) | _bt(.))\("/"+($month) | __(.)) \($hour)\((":")+($min) | __(.))";

# toggl hours minutes
def prettyStatus:
if (. | contains("Up")) then ("Up" | rp(11) | _g(.))+" "+(captureTimeAfterUp)
  elif (. | contains("Exited")) then 
      _r("Exited ")+" "+(captureExitCode | prettyExit | lp(3))+" "+(captureTimeAgoAfterExitCode | __(.))
  elif (. | contains("Created")) then _bt("Created")
  else . 
end;
