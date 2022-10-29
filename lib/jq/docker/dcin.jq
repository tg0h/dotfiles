include "pad";
include "colour";
include "colour-scale";

def _pathArgs:
  "\(.Path | _fp(.) ) \(.Args | join(" ") | _m(.))";

def __running: if . == true then "R" | _g(.) else "R" | __(.) end;
def __paused: if . == true then "P" | _y(.) else "P" | __(.) end;
def __restarting: if . == true then "RS" | _y(.) else "RS" | __(.) end;
def __oomKilled: if . == true then "OOM" | _r(.) else "OOM" | __(.) end;
def __dead: if . == true then "D" | _r(.) else "D" | __(.) end;
def __exitCode: if . == 0 then "0" | _g(.) else . | tostring | _r(.) end;
def __status: 
  if . == "running" then _g("R")
  elif . == "exited" then  _r("X") else
  . 
  end;
def _state:
  "\(.Status|__status)"
  # +" \(.Running|__running)"
  +" \(.Paused|__paused) \(.Restarting|__restarting) \(.OOMKilled|__oomKilled) \(.Dead|__dead) "
  +"\(.Pid|tostring|__u(.)) "
  +"\(.ExitCode|__exitCode) \(.Error)"
  ;

def __binds:
  if length == 0 then "" else
  "\n" + (map(. | split(":") | .[0] as $hostDir | .[1] as $containerDir | "\($hostDir|lp(62)|__(.))\(":"|__(.))\($containerDir|_b(.))") | join("\n"))
  end;
def __networkModeLabel: "Network Mode:"|__(.);
def __portBindingsLabel: "Port Bindings:"|__(.);

def __hostIpPort: 
  "\(.HostIp):\(.HostPort)";
def ___portBinding: 
    .key as $pbKey |
    .value as $pbValueArray |
    "\($pbKey|_y(.))\("|"|__(.))\($pbValueArray | map(__hostIpPort) |join(""))"
    ;

def __portBindings: if length == 0 then "" else 
  to_entries | map (___portBinding) | join("\(", "|__(.))")
end;
def _hostConfig:
  "  \(__networkModeLabel|lp(23))\(.NetworkMode|__(.))\n"
  + "  \(__portBindingsLabel|lp(23))\(.PortBindings|__portBindings)"
  + "\(.Binds | __binds)"
  ;

def __attachStdIn: if . == true then "&0" | _g(.) else "&0" | __(.) end;
def __attachStdOut: if . == true then "&1" | _g(.) else "&1" | __(.) end;
def __attachStdErr: if . == true then "&2" | _g(.) else "&2" | __(.) end;
def __tty: if . == true then "tty" | _g(.) else "tty" | __(.) end;
def __openStdIn: if . == true then "openStdIn" | _g(.) else "openStdIn" | __(.) end;
def __stdInOnce: if . == true then "stdInOnce" | _g(.) else "stdInOnce" | __(.) end;

def __exposedPortsValue: if length == 0 then "" else . end;
def _exposedPorts: if . == null then "" else
  "\n"+(to_entries|map("\(.key|lp(15)|_brinkPink(.))\(":"|__(.))\(.value|__exposedPortsValue)") | join ("\n")) end;

def _env:
  if length == 0 then "" else "\n"+(map(. | split("=") | .[0] as $envVar | .[1] as $envVarValue | "\($envVar|lp(40)|_y(.))\("="|__(.))\($envVarValue|_sdb(.))") | join("\n")) end;

def __volumesLabel: "VOL:"|lp(14)|__(.);
def __workingDirLabel: "WD:"|lp(14)|__(.);
def __entryPointLabel: "ENTRY:"|lp(14)|__(.);
def __entryPoint: if . == null then "" else . | join (" ") | __(.) end;
def _cmd: if . == null then "" else .|join(" ")|_m(.) end;

def __volumeValue: if length == 0 then "" else
  . 
  end
  ;
def __volumes: if . == null then "" else
    to_entries | map("\(.key|__(.))\(":"|__(.))\(.value|__volumeValue)" ) | join ("\(" , "|__(.))")
  end;

def __exposedPortsLabel: "Exposed Ports >"|lp(14)|__(.);
def _config:
  "  \(.Image|_tacha(.)) "
  + "\(.Cmd|_cmd)\n"
  + "  "
  +__volumesLabel+"\(.Volumes|__volumes)\n"
  + "  "+__workingDirLabel+"\(.WorkingDir|__(.)//"")\n"
  + "  "+__entryPointLabel+"\(.Entrypoint|__entryPoint)\n"
  + "    \(.AttachStdin|__attachStdIn) \(.AttachStdout|__attachStdOut) \(.AttachStderr|__attachStdErr) "
  + "\(.Tty|__tty) "
  + "\(.OpenStdin|__openStdIn) \(.StdinOnce|__stdInOnce)\n"
  + "\(__exposedPortsLabel|lp(25))\(.ExposedPorts|_exposedPorts)"
  + "\(.Env|_env)"
  ;

def __rw: if . == true then "RW" | _g(.) else "RW" | __(.) end;
def _mounts: if length == 0 then "" else
  (map("  \(.Type|__(.)) \(.Source | lp(55) | __(.))\(":"|__(.))\(.Destination|rp(40)|_b(.)) \(.Mode) \(.RW|__rw) \(.Propagation|__(.))") 
  | join("\n"))+"\n" end;

def __bridge: ("Bridge:"|__(.)) + . ;
def __gateway: ("Gateway:"|__(.)) + (.|__(.));
def __ipAddress: ("IP:"|__(.)) + (.|__(.));
def __macAddress: ("MAC:"|__(.)) + (.|__(.));
def __aliases: ("Aliases:"|__(.)) + if . == null then "" else join(", ") | (.|__(.)) end;

def __portsHostValue: if . == null then "" else 
  map("\(.HostIp):\(.HostPort)"|__(.))|join(",") end
  ;
def __ports: if length == 0 then "" else 
  "\n"+(.|to_entries|map("\(.key|lp(15)|_brinkPink(.))\(":"|__(.))\(.value|__portsHostValue)") | join ("\n")) end;

def __ipPrefixLength: if . == null then "" else ("/"|__(.)) + (.|tostring|__(.)) end;

def ___network:
  "        \(.Gateway|__gateway)\n"
  +"             \(.IPAddress|__ipAddress)"
  +"\(.IPPrefixLen|__ipPrefixLength)\n"
  +"            \(.MacAddress|__macAddress)\n"
  +"        \(.Aliases | __aliases)\n"
  ;
def __network: "  \(.key|_g(.))\n\(.value|___network)";
def _networks: to_entries | map(__network) | join ("\n");

def __portsLabel: "Ports >"|lp(16)|__(.);
def __networksLabel: "Networks >"|lp(16)|__(.);
def _networkSettings:
  "         \(.Bridge|__bridge)\n"
  +"        \(.Gateway|__gateway)\n "
  +"            \(.IPAddress|__ipAddress)\n "
  +"           \(.MacAddress|__macAddress)\n"
  +"\(__portsLabel)\(.Ports|__ports)\n"
  + "\(__networksLabel)\n\(.Networks | _networks)"
  ;

def hostConfigHeader: "HOST CONFIG"|_orange(.)+"\n";
def mountsHeader: "MOUNTS"|_bt(.)+"\n";
def configHeader: "CONFIG"|_y(.)+"\n";
def networkHeader: "NETWORK SETTINGS"|_g(.)+"\n";

def __platformLabel: "platform:"|__(.);
def __driverLabel: "driver:"|__(.);
def dcin:
 .[] | 

 "\(.Name|_cs0)"
 + " \(.Id|__(.))\n" 
 + "  \({Path, Args} | _pathArgs)\n"
 + "  \(.State | _state)"
 + "\(__platformLabel)\(.Platform|__(.)) \(__driverLabel)\(.Driver|__(.))\n"
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
