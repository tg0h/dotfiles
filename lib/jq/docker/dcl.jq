include "pad";
include "colour";
include "colour-scale";
include "docker";
include "docker/dcin";
include "docker/docker.image-tag";
include "docker/docker.time";
include "docker/docker.bytes-format";

def image:
 # truncate and highlight aws ecr prefix
 # gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"...")|_("bblue"))+(.x | _tacha(.)));
 gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"..."))+(.x));

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
# TODO: Up About a minute :|
# Up About an hour
# if capturing group does not capture, pass through input
# .timeUp? - optionally index object
# if null, pass through with //
# capture returns an object with the capture group, HOWEVER if the regex does not match
# the input is EATEN
# this means you lose data if you use capture carelessly :|
def captureTimeAfterUp:
  (capture("Up (?<timeUp>((\\d)+ (\\w)*))") // .) | .timeUp?[0:6] // (. | captureAboutTimeAfterUp | "~1 "+.[0:3]) ;

# def prettyStatus:
# if (. | contains("Up")) then ("U" | rp(11) | _g(.))+" "+(captureTimeAfterUp)
#   elif (. | contains("Exited")) then 
#       _r("X")+" "+(captureExitCode | prettyExit | lp(3))+" "+(captureTimeAgoAfterExitCode | __(.))
#   elif (. | contains("Created")) then _bt("Created")
#   else . 
# end;

def prettyStatus:
if (. | contains("Up")) then "U" | _g(.)+"    "
  elif (. | contains("Exited")) then _r("X")+" "+(captureExitCode | prettyExit)
  elif (. | contains("Created")) then _bt("C")+"    "
  else . 
end;

def setImageSortKey:
  ._repository as $repo |
  if $repo | startswith("203") then ._sortKey = 3 # rc images
  elif $repo | contains("/") then ._sortKey = 2 # images from docker registry
  else ._sortKey = 1 # local images
  end
;

def setRepository:
  (.Image | split(":") | .[0]) as $repository
  | ._repository = $repository
;
def setTag:
  (.Image | split(":") | .[1]) as $tag
  | ._tag = ($tag // "")
;

def setHostIpPorts:
  (.Ports | split("->") | .[0] // "") as $hostIpPorts
  | ($hostIpPorts | split(":") | .[0]) as $hostIp
  | ($hostIpPorts | split(":") | .[1]) as $hostPorts
  | ._hostIp = $hostIp
  | ._hostPorts = $hostPorts
;

def setContainerPortsSocket:
  (.Ports | split("->") | .[1] // "") as $containerPortsSocket
  | ($containerPortsSocket | split("/") | .[0]) as $containerPorts
  | ($containerPortsSocket | split("/") | .[1]) as $containerSocket
  | ._containerPorts = $containerPorts
  | ._containerSocket = $containerSocket
;

# "Up About a minute"
# "Up About an hour"
# "Up 4 minutes"
# "Up 40 minutes"
def getUpTime:
  if contains("Up About") then 
      (capture("Up About (a|an) (?<timeUp>((\\w)*))") | .timeUp) as $unit
      | { timeUp : 1, unit : ($unit+"s")}
  else
     capture("Up (?<timeUp>(\\d)+) (?<unit>(\\w)*)")
  end;
def getExitStatus:
  capture("(?<exitCode>([0-9]{1,3}))\\) (?<time>(\\d*)) (?<unit>(\\w)*)");

def setStatusAgo:
  if (.Status | contains("Up")) then ._upTime = (.Status | getUpTime) 
  elif (.Status | contains("Exited")) then ._exitStatus = (.Status | getExitStatus) 
  else .
  end
;

# "About a minute ago"
# "9 hours ago"
# "3 days ago"
def getRunningTime:
  if contains("About") then 
      (capture("About (a|an) (?<unit>((\\w)*))") | .unit) as $unit
      | { time : 1, unit : ($unit+"s")}
  else
     capture("(?<time>(\\d)+) (?<unit>(\\w)*)")
  end;

def setRunningTime:
  ._runningFor = (.RunningFor | getRunningTime) 
;

# "/host_mnt/User…,/host_mnt/User…"
# "/host_mnt/User…"
# ""
def setMounts:
  (.Mounts | split(",") | length ) as $numberOfMounts
  | ._mounts = $numberOfMounts
;

# "0B (virtual 104MB)"
# "869kB (virtual 1.54GB)"
# "791MB (virtual 4.92GB)"
def setSize:
  (.Size 
  | capture("(?<size>([0-9]{1,3}))(?<sizeUnit>(\\w)*) \\(virtual (?<virtualSize>([\\d.]*))(?<virtualUnit>(\\w)*)")
  ) as $__size
  | .__size = $__size
;

def _formatPortBinding($hostIp;$hostPorts;$containerPorts;$containerSocket):
  (if $hostIp == "0.0.0.0" then "_" else $hostIp end) as $_hostIp
  | if $hostIp == null then "" else
    __($_hostIp) + __(":") + _mg($hostPorts) + _g("->") + _brinkPink($containerPorts) + __("/") + __($containerSocket)
  end
;

def _daemon: sub("(?<c>daemon)";((.c|_cs6)));
def _composer: sub("(?<c>composer)";(_b(.c)));
def _redis: sub("(?<c>redis)";(.c|_cs12));
def _dash: gsub("(?<d>-)";(__(.d)));
def _one: sub("(?<d>1$)";(__(.d)));
def _dynamodb: sub("(?<w>dynamodb)";(__u(.w)));
def _db: sub("(?<w>db)";(__u(.w)));
def _sqs: sub("(?<w>sqs)";((.w|_cs4)));
def _cerberus: sub("(?<w>cerberus)";((.w|_cs4)));
def _campaign: sub("(?<w>campaign)";((.w|_g(.))));
def _beanstalkd: sub("(?<w>beanstalkd)";(___(.w)));
def _default: sub("(?<w>default)";(_fp(.w)));
def _long: sub("(?<w>long)";(_ec(.w)));
def _names:
  _composer 
  | _daemon 
  | _redis 
  |  _dash 
  | _one 
  | _dynamodb 
  | _db 
  | _sqs 
  | _cerberus 
  | _campaign 
  | _beanstalkd 
  | _default
  | _long
;

def showUpTime:
 if ._upTime | length > 0 then 
   (._upTime|.timeUp ) as $time 
   | (._upTime|.unit) as $unit
   # | "\($timeUp) \($unit)"
   | upDownTimeFormat($time;$unit)
 elif ._exitStatus | length > 0 then 
   (._exitStatus|.time ) as $time
   | (._exitStatus|.unit) as $unit
   # | "\($time) \($unit)"
   | upDownTimeFormat($time;$unit)
 else "     " end;

def showRunningTime:
  (._runningFor|.time) as $time
 | (._runningFor|.unit) as $unit
 | upDownTimeFormat($time;$unit);

def showMounts:
  (.|tostring) as $numberOfMounts
  | if . == 0 then _ebony($numberOfMounts)
    elif . == 1 then _steel($numberOfMounts)
    elif . == 2 then __($numberOfMounts)
    else _aluminium($numberOfMounts)
    end;

def showVolumes:
  (.|tonumber) as $num
  | if $num == 0 then _ebony(.)
    elif $num == 1 then _steel(.)
    elif $num == 2 then __(.)
    else _aluminium(.)
    end;

def showSize:
  .size as $size
  | .sizeUnit as $sizeUnit
  | .virtualSize as $vSize
  | .virtualUnit as $vUnit
  | "\(DockerBytesFormat($vSize;$vUnit;4)) \(DockerBytesFormat($size;$sizeUnit;4))"
  ;

def dcl:
   # sort by status descending (show up first then exit). ignore the exit code (whether exit 0 or exit 127 etc) by just getting the first 2 chars of exit. 
   # then sort by name ascending
   map(setRepository)
   | map(setTag)
   | map(setImageSortKey)
   | map(setHostIpPorts)
   | map(setContainerPortsSocket)
   | map(setStatusAgo)
   | map(setRunningTime)
   | map(setMounts)
   | map(setSize)
   | sort_by((.Status[0:2] | explode | map(-.)), .ImageSortKey, .Names)
   | .[]
   |"\(.ID[0:5] | __(.)) "
   +"\(._mounts | showMounts) "
   +"\(.LocalVolumes | showVolumes) "
   +"\(.__size | showSize) "
   + showRunningTime # since created ?
   + showUpTime
   +" "
   +"\(.Status | prettyStatus) "
   +"\(.Names[0:30] | lp(30) | _names)"
   +" \(._repository|_repository|lp(30)) \(._tag|_tag|lp(3) ) "
   +"\( _formatPortBinding(._hostIp;._hostPorts;._containerPorts;._containerSocket))"
   ;

   # +"\(.Command[1:-1] | __(.)) "
   # +"\(.Command[1:11] | rp(10) | __(.)) "
   # +" \(.CreatedAt|pCreatedAt) "

