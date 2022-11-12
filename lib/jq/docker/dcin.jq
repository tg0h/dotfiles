include "pad";
include "colour";
include "colour-scale";
include "docker/docker-container.time";

def _LMARGIN: lp(20);
def __HEADER($header): $header | _LMARGIN | __(.);


def __binds:
  if length == 0 then "" else
   map( 
       split(":") 
       | .[0] as $hostDir 
       | .[1] as $containerDir 
       | "\($hostDir|__(.))"
            +"\(":"|_g(.))"
            +"\($containerDir|_b(.))"
      ) | join("\n \(ljust(18)) ")
  end;

def __hostIpPort: 
  "\(.HostIp|__(.))\(__(":"))\(.HostPort|_mg(.))";
def ___portBinding: 
    .key as $pbKey |
    .value as $pbValueArray |
    "\($pbKey|_brinkPink(.))\("->"|_g(.))\($pbValueArray | map(__hostIpPort) |join(""))"
    ;

def __portBindings: if length == 0 then "" else 
  to_entries | map (___portBinding) | join("\(", "|__(.))")
end;
def _hostConfig:
   __HEADER("Network Mode: ")+   "\(.NetworkMode|__(.))\n"
   +__HEADER("Port Bindings: ")+ "\(.PortBindings|__portBindings)\n" 
   +__HEADER("Binds: ")+ "\(.Binds | __binds)"
  ;

def __attachStdIn: if . == true then "&0" | _g(.) else "&0" | __(.) end;
def __attachStdOut: if . == true then "&1" | _g(.) else "&1" | __(.) end;
def __attachStdErr: if . == true then "&2" | _g(.) else "&2" | __(.) end;
def __tty: if . == true then "tty" | _g(.) else "tty" | __(.) end;
def __openStdIn: if . == true then "openStdIn" | _g(.) else "openStdIn" | __(.) end;
def __stdInOnce: if . == true then "stdInOnce" | _g(.) else "stdInOnce" | __(.) end;

def __exposedPortsValue: if length == 0 then "" else . end;
def _exposedPorts: if . == null then "" else 
    to_entries | map("\(.key|_brinkPink(.))\("->"|_g(.))\(.value|__exposedPortsValue)") | join ("\n \(ljust(18)) ")
  end;

def _env: if length == 0 then "" else "\n"
  +( map(. 
      | split("=") 
      | .[0] as $envVar 
      | .[1] as $envVarValue 
      | "\($envVar|lp(35)|_y(.))\("="|__(.))\($envVarValue|_sdb(.))"
   )  | join("\n")) 
  end;

def __entryPoint: if . == null then "" else . | join (" ") | __(.) end;
def _cmd: if . == null then "" else .|join(" ")|_m(.) end;
def __volumeValue: if length == 0 then "" else . end ;
def __volumes: if . == null then "" else
    to_entries | map("\(.key|_orange(.))\(":"|_g(.))\(.value|__volumeValue)" ) | join ("\n \(ljust(19))")
  end;

def _config:
    __HEADER("Image: ")+"\(.Image|_tacha(.))\n"
  + ljust(11)+_g("Streams")+__(": ")
    +"\(.AttachStdin|__attachStdIn) \(.AttachStdout|__attachStdOut) \(.AttachStderr|__attachStdErr) "
    + "\(.Tty|__tty) "
    + "\(.OpenStdin|__openStdIn) \(.StdinOnce|__stdInOnce)\n"
  + __HEADER("Cmd: ")+ "\(.Cmd|_cmd)\n"
  + __HEADER("Entry point: ")+"\(.Entrypoint|__entryPoint)\n"
  + __HEADER("Working Dir: ")+"\(.WorkingDir|__(.)//"")\n"
  + __HEADER("Volumes: ")+"\(.Volumes|__volumes)\n"
  + __HEADER("Exposed Ports: ")+"\(.ExposedPorts|_exposedPorts)\n"
  + "\(.Env|_env)"
  ;

def __rw: if . == true then "RW" | _g(.) else "RW" | __(.) end;

def showMountType: 
  if . == "bind" then .|lp(18)
  else .|lp(18)|__(.)
  end;

def _mounts: if length == 0 then "" else
  (
  map(
    # ljust(14)
    # +
    "\(.Type|showMountType) "
    +"\(.Source | __(.))"
    +"\(":"|_g(.))"
    +"\(.Destination|_b(.))" 
    +" "
    +"\(.Mode)"
      +" \(.RW|__rw)"
      +" "
      +"\(.Propagation|__(.))"
  ) 
  | join("\n")
  )+"\n" end;

def __gateway: ("Gateway:"|__(.)) + (.|__(.));
def __ipAddress: ("IP:"|__(.)) + (.|__(.));
def __macAddress: ("MAC:"|__(.)) + (.|__(.));
def __aliases: if . == null then "" else map(__(.)) | join("\(_g(",")) ") end;

def __portsHostValue: if . == null then "" else 
  map("\(.HostIp|__(.))\(":")\(.HostPort|_mg(.))"|__(.))|join(",") end
  ;
def __ports: if length == 0 then "" else 
    to_entries | map("\(.key|_brinkPink(.))\("->"|_g(.))\(.value|__portsHostValue)") | join ("\n\(ljust(20))") 
  end;

def __ipPrefixLength: if . == null then "" else ("/"|__(.)) + (.|tostring|__(.)) end;

def ___network:
  __HEADER("Gateway: ")+"\(__(.Gateway))\n"
  +__HEADER("IP Address: ")+"\(__(.IPAddress))"
    +"\(.IPPrefixLen|__ipPrefixLength)\n"
  +__HEADER("MAC Address: ")+"\(__(.MacAddress))\n"
  +__HEADER("Aliases: ")+ "\(.Aliases | __aliases)\n"
  ;
def __network: "\(.key|lp(19)|_cs2)\n\(.value|___network)";
def _networks: to_entries | map(__network) | join ("\n");

def _networkSettings:
  __HEADER("Bridge: ")+"\(.Bridge)\n"
  +__HEADER("Gateway: ")+"\(__(.Gateway))\n"
  +__HEADER("IP Address: ")+"\(__(.IPAddress))\n"
  +__HEADER("MAC Address: ")+"\(__(.MacAddress))\n"
  +__HEADER("Ports: ")+"\(.Ports|__ports)\n"
  + __HEADER("Networks:\n")+ "\(.Networks | _networks)"
  ;

def hostConfigHeader: "HOST CONFIG"|_orange(.)+"\n";
def mountsHeader: "MOUNTS"|_bt(.)+"\n";
def configHeader: "CONFIG"|_y(.)+"\n";
def networkHeader: "NETWORK SETTINGS"|_g(.)+"\n";

def __platformLabel: "platform:"|__(.);
def __driverLabel: "driver:"|__(.);

def _pathArgs:
  "\(.Path | _fp(.) ) \(.Args | join(" ") | _m(.))";

def __running: if . == true then "R" | _g(.) else "R" | __(.) end;
def __paused: if . == true then "P" | _y(.) else "P" | __(.) end;
def __restarting: if . == true then "RS" | _y(.) else "RS" | __(.) end;
def __oomKilled: if . == true then "OOM" | _r(.) else "OOM" | __(.) end;
def __dead: if . == true then "D" | _r(.) else "D" | __(.) end;
def __exitCode: if . == 0 then "0" | _g(.) else . | tostring | _r(.) end;
def __status: if . == "running" then _g("R")
              elif . == "exited" then  _r("X")
              elif . == "created" then  _bt("C")
              else . end;
def _state:
  "\(.Status|__status) "
    # +" \(.Running|__running)"
    +"\(.Paused|__paused) "
    +"\(.Restarting|__restarting) "
    +"\(.OOMKilled|__oomKilled) "
    +"\(.Dead|__dead) "
  +"\(.Pid|tostring|__(.)) "
  +"\(.ExitCode|__exitCode) \(.Error|_r_u(.))"
  ;

def _minutes:
  (. |tostring|lp(3)) as $time |
  if . < 10 then $time | _cs0
  elif . < 20 then $time | _cs1
  elif . < 30 then $time | _cs2
  elif . < 40 then $time | _cs3
  elif . < 50 then $time | _cs4
  else $time | _cs5
  end
  ;

def _hours:
  (. |tostring|lp(3)) as $time |
  if . < 2 then $time | _cs6
  elif . < 3 then $time | _cs7
  elif . < 4 then $time | _cs8
  elif . < 5 then $time | _cs9
  elif . < 6 then $time | _cs10
  elif . < 7 then $time | _cs11
  elif . < 8 then $time | _cs12
  elif . < 9 then $time | _cs13
  else $time | _cs14
  end
  ;

def _days:
  (. |tostring|lp(3)) as $time |
  # if . < 3 then $time | _cs6
  # elif . < 7 then $time | _cs7
  # elif . < 14 then $time | _cs8
  if . < 21 then $time | _cs15
  else $time | _cs15
  end
  ;

def _months:
  (. |tostring|lp(3)) as $time |
  $time | _cs15
  ;

def upDownTimeFormat($humanSize;$unit): 
  if $humanSize == null then ""
  elif $unit == "seconds" then __($humanSize|lp(3)) + " " + _ebony("s")
  elif $unit == "minutes" then $humanSize|_minutes + " " + "\(_ebony("m"))"
  elif $unit == "hours" then $humanSize|_hours + " " + "\(_tacha("h"))"
  elif $unit == "days" then $humanSize|_days + " " + "\(_bgr("D"))"
  else
    $humanSize|_months + " " +_ec("mth")
  end ;


def _secondsToUnit:
  if . <= 60 then "seconds"
  elif . <= 60*60 then "minutes"
  elif . <= 24*60*60 then "hours"
  elif . <= 30*24*60*60 then "days"
  else "months"
  end;


def _roundTo1Dp: .*10.0|round/10.0;

def _secondsToHumanSize:
  60 as $minutes
  | (60 * 60) as $hours
  | (24 * 60 * 60 ) as $days
  | (30 * 24 * 60 * 60 ) as $months
  | if . <= 60 then .
    elif . <= 60*60 then ( . / $minutes | round )
    elif . <= 24*60*60 then ( . / $hours | _roundTo1Dp )
    elif . <= 30*24*60*60 then ( . / $days | _roundTo1Dp )
    else ( . / $months | _roundTo1Dp )
    end;

def _setCreated:
  (.Created[0:19]+"Z"| fromdate ) as $unixTime
  | ._created = $unixTime
  ;
def _setStartedAtAndMinutesAgo:
  if .State.StartedAt == "0001-01-01T00:00:00Z" then ._startedAt = null
  else
    (.State.StartedAt[0:19]+"Z"| fromdate ) as $unixTime
    | (now - $unixTime) as $secondsAgo 
    | ($secondsAgo/(60)|floor ) as $minutesAgo 
    | ._startedMinutesAgo = $minutesAgo
    | ._startedAt = $unixTime
  end
  ;
def _setFinishedAt:
  if .State.FinishedAt == "0001-01-01T00:00:00Z" then ._finishedAt = null
  else
    (.State.FinishedAt[0:19]+"Z"| fromdate ) as $unixTime
    | ._finishedAt = $unixTime
  end
  ;

def _setDuration:
  # when creation of container fails
  # or when it has never finished before
  if (._startedAt == null or ._finishedAt == null) 
  then ._duration = null
  else
    (._finishedAt - ._startedAt ) as $duration
    | ( now - ._startedAt ) as $nowDuration
    | if $duration > 0 then
        ._duration = $duration
      else
        ._duration = $nowDuration
      end
  end
  ;
def _setCreatedDuration:
  ( now - ._created ) as $duration
  | ._createdDuration = $duration
  ;

def _showTime($startedMinutesAgo):
 if (._startedAt == null and ._finishedAt == null) then
    __HEADER("Started At: ")+"\(.State.StartedAt[0:19]|tostring|_ebony(.) )\n"
  + __HEADER("Finished At: ")+"\(.State.FinishedAt[0:19]|tostring|_ebony(.) )\n"
 elif (._startedAt != null and ._finishedAt == null) then
    __HEADER("Started At: ")+"\(.State.StartedAt|isoUTCtoSG|_FormatTimeFinishedAt|__(.) )\n"
  + __HEADER("Finished At: ")+"\(.State.FinishedAt[0:19]|tostring|_ebony(.) )\n"
 else 
    (._finishedAt - ._startedAt) as $duration
    | if $duration > 0  then
        __HEADER("Started At: ")+"\(.State.StartedAt |isoUTCtoSG|FormatTime($startedMinutesAgo)) \n"
      + __HEADER("Finished At: ")+"\(.State.FinishedAt|isoUTCtoSG|_FormatTimeFinishedAt) \(upDownTimeFormat(._humanSize;._unit))\n"
      else
        __HEADER("Started At: ")+"\(.State.StartedAt|isoUTCtoSG|FormatTime($startedMinutesAgo)) \(upDownTimeFormat(._humanSize;._unit))\n"
      + __HEADER("Finished At: ")+"\(.State.FinishedAt|isoUTCtoSG[0:19]|_FormatTimeFinishedAt )\n"
      end
  end
;

def dcin:
  map(_setCreated)
  | map(setCreatedMinutesAgo)
  | map(_setCreatedDuration)
  | map((if ._createdDuration == null then null else ._createdDuration|fabs|_secondsToUnit end) as $unit | ._createdUnit = $unit)
  | map((if ._createdDuration == null then null else ._createdDuration|fabs|_secondsToHumanSize end) as $humanSize | ._createdHumanSize = $humanSize)
  | map(_setStartedAtAndMinutesAgo)
  | map(_setFinishedAt)
  | map(_setDuration) # duration can be null if creation failed
  | map((if ._duration == null then null else ._duration|fabs|_secondsToUnit end) as $unit | ._unit = $unit)
  | map((if ._duration == null then null else ._duration|fabs|_secondsToHumanSize end) as $humanSize | ._humanSize = $humanSize)
  | .[] 
  | ._createdMinutesAgo as $createdMinutesAgo
  | ._startedMinutesAgo as $startedMinutesAgo
  | "\(ljust(20))"+"\(.Name|_cs0) "
      + "\(.Id|trunc(10)|__(.)) "
        + "\(.Platform|_ebony(.)) "
        + "\(.Driver|_ebony(.))\n"
      + __HEADER("State: ")+"\(.State | _state)\n"
      + __HEADER("Path/Args: ")+"\({Path, Args} | _pathArgs)\n"
      # + "_startedAt:  \(._startedAt) \(upDownTimeFormat(._humanSize;._unit))\n"
      # + "_finishedAt: \(._finishedAt)\n"
      # + "_duration: \(._duration)\n"
      # + "_createdMinutesAgo: \(._createdMinutesAgo)\n"
      # + "_startedMinutesAgo: \(._startedMinutesAgo)\n"
      # + "createdduration: \(._createdDuration)\n"
      # + "createdHumanSize: \(._createdHumanSize)\n"
      + __HEADER("Created At: ")+"\(.Created|isoUTCtoSG|FormatTime($createdMinutesAgo)) \(upDownTimeFormat(._createdHumanSize;._createdUnit)) \n"
      + _showTime($startedMinutesAgo)
      # + "Log Path:\(.LogPath|__(.))\n" # location of logs in docker vm - use nsenter to view

      + hostConfigHeader
      +"\(.HostConfig|_hostConfig)\n"

      +mountsHeader
      +"\(.Mounts|_mounts)"

      +configHeader
      +"\(.Config|_config)\n"

      +networkHeader
      +"\(.NetworkSettings|_networkSettings)"
      ;
