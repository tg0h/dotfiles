include "pad";
include "colour";
include "colour-scale";
include "docker/docker.size";
include "docker/docker.bytes-format";
include "docker/docker.time";
include "docker/docker.image-tag";

def _LMARGIN: lp(20);
def __HEADER($header): $header | _LMARGIN | __(.);
def __HEADER2($header): $header | lp(21) | __(.);

def __attachStdIn: if . == true then "&0" | _g(.) else "&0" | __(.) end;
def __attachStdOut: if . == true then "&1" | _g(.) else "&1" | __(.) end;
def __attachStdErr: if . == true then "&2" | _g(.) else "&2" | __(.) end;
def __tty: if . == true then "tty" | _g(.) else "tty" | __(.) end;
def __openStdIn: if . == true then "openStdIn" | _g(.) else "openStdIn" | __(.) end;
def __stdInOnce: if . == true then "stdInOnce" | _g(.) else "stdInOnce" | __(.) end;

def _env: 
  if length == 0 then "" 
  else (
        map(. 
          | split("=") 
          | .[0] as $envVar 
          | .[1] as $envVarValue 
          | "\($envVar|lp(19)|_y(.))"
            +"\("="|__(.))"
            +"\($envVarValue|_sdb(.))") 
          | join("\n")) 
  end;

def __entryPoint: if . == null then "" else . | join (" ") | _cs11 end;
def _cmd: if . == null then "" else .|join(" ")|_m(.) end;
def __volumeValue: if length == 0 then "" else . end ;
def __volumes: if . == null then "" else
    to_entries | map("\(.key|__(.))\(":"|__(.))\(.value|__volumeValue)" ) | join ("\(" , "|__(.))")
  end;

def _subSha256: sub("sha256:";"");

def _config:
  ljust(12)+_g("Streams")+__(": ")
    + "\(.AttachStdin|__attachStdIn) \(.AttachStdout|__attachStdOut) \(.AttachStderr|__attachStdErr) "
    + "\(.Tty|__tty) \(.OpenStdin|__openStdIn) \(.StdinOnce|__stdInOnce)\n"
  +__HEADER2("Cmd: ")+ "\(.Cmd|_cmd)\n"
  +__HEADER2("Image: ")+ "\(__(.Image|_subSha256|trunc(10)))\n"
  +__HEADER2("Entry point: ")+"\(.Entrypoint|__entryPoint)\n"
  # +__HEADER2("Working Dir: ")+"\(.WorkingDir|__(.)//"")\n"
  +__HEADER2("Working Dir: ")+"\(colour(.WorkingDir; "ebony_bg")//"")\n"
  +__HEADER2("Volumes: ")+"\(.Volumes|__volumes)\n"
  +"\n"
  +"\(.Env|sort|_env)\n"
  +"\n"
  +__HEADER2("Host name: ")+"\(.Hostname|__(.))\n"
  +__HEADER2("Domain name: ")+"\(.Domainname|__(.))\n"
  +__HEADER2("User: ")+"\(.User)"
  ;

def containerConfigHeader: "CONTAINER CONFIG"|_y(.)+"\n";
def configHeader: __("CONFIG")+"\n";

def _architecture: if . == "amd64" then _b(.) elif . =="arm64" then _brinkPink(.) else . end;
def _roundTo2Dp: .*100.0|round/100.0;

def _sizeToIec:
  1000 as $kbInB
  | (1000 * 1000) as $mbInB
  | (1000 * 1000 * 1000 ) as $gbInB
  | if . < $mbInB then (. / $kbInB | round | tostring)
  elif . < $gbInB then (. / $mbInB | round | tostring)
  else (. / $gbInB | _roundTo2Dp | tostring)
  end;


def _bytesToUnit:
  1000 as $kbInB
  | (1000 * 1000) as $mbInB
  | (1000 * 1000 * 1000 ) as $gbInB
  | if . < $mbInB then "kB"
  elif . < $gbInB then "MB"
  else "GB"
  end;

def _size:
  if ._sizeUnit == ._virtualSizeUnit and .Size == .VirtualSize then
    "\(DockerBytesFormat(.Size|_sizeToIec;._sizeUnit;0))"
  else
    "\(DockerBytesFormat(.Size|_sizeToIec;._sizeUnit;0))"
    +"\(__("/"))"
    +"\(DockerBytesFormat(.Size|_sizeToIec;._sizeUnit;0))"
  end
;

def _setMonthsAgo:
  (.Created[0:19]+"Z"| fromdate ) as $createdUnixTime 
  | (now - $createdUnixTime) as $secondsAgo 
  | ($secondsAgo/(60*60*24*30)|floor ) as $monthsAgo 
  | ._monthsAgo = $monthsAgo
;

def _mapRepoTags($isPadded):
  map(split(":"))
  | map( 
      .[0] as $image 
      | .[1] as $tag 
      | "\($image | _repository) \($tag | _tag)"
    )
  | join ("\n"+"\(" "|lp(21))");
      
def _repoTags: 
  if . == null then "" else 
    if length == 1 then _mapRepoTags(false)
    else _mapRepoTags(true)
    end
end;

def _metadataLastTagTime($monthsAgo): 
  if . == "0001-01-01T00:00:00Z" then __("01/01/01 00:00")
  else FormatCreatedAtTime($monthsAgo)
  end
  ;

def dii:
 map(((.Size|_bytesToUnit) as $unit | ._sizeUnit = $unit))
 | map(((.VirtualSize|_bytesToUnit) as $unit | ._virtualSizeUnit = $unit))
 | map(_setMonthsAgo)

 | .[] 

 | ._monthsAgo as $monthsAgo
 |
 "\(__HEADER("Id:")) \(.Id|_subSha256|trunc(10)|__(.))" 
 +" \({Size,_sizeUnit,VirtualSize,_virtualSizeUnit}|_size)" 
 +"\n"
 +"\(__HEADER("Architecture/OS:")) \(.Architecture|_architecture) \(__(.Os)) " 
 # +"\(__HEADER("Size:")) 
 +"\n"

 # This container identifier is a temporary container created when the image was built. Docker will create a container during the image construction process, and this identifier is stored in the image data.
 # +"\(.Container|trunc(10)|__(.)) " 
 # +"\n"
 
 + __HEADER("Created/Last Tag At:")+" \(.Created|FormatCreatedAtTime($monthsAgo))"
 +" \(.Metadata.LastTagTime|_metadataLastTagTime($monthsAgo))\n"
 # + __HEADER("Last Tag Time:")
 + __HEADER("Repo Tags:")+" \(.RepoTags|_repoTags)\n"
 + __HEADER("Comment:")+" \(__(.Comment))\n"
 + __HEADER("Docker Version:")+" \(.DockerVersion|__(.))\n"

# The ContainerConfig of an image is the container the image was generated from.
# This data again is referring to the temporary container created when the Docker build command was executed.
# see docker history <image>
# https://stackoverflow.com/questions/36216220/what-is-different-of-config-and-containerconfig-of-docker-inspect
# +containerConfigHeader
#  +"\(.ContainerConfig|_config)\n"

 +configHeader
 +"\(.Config|_config)"
 ;
