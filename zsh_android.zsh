# SCRCPY ==========================================================================

function sc() {
  if [[ $# -eq 2 ]]; then
    scrcpy -s 192.168.$1.$2:5555
  else;
    scrcpy -s 192.168.1.$1:5555
  fi
}

function sca() {
  #always on top

  if [[ $# -eq 2 ]]; then
    scrcpy -s 192.168.$1.$2:5555 --always-on-top
  else;
    scrcpy -s 192.168.1.$1:5555 --always-on-top
  fi
}


# ADB ==========================================================================

function aip() {
  # gets the ip of the phone connected via usb
  adb -d shell ip route
}

function atcp() {
  # before connecting to the device, tell the device to listen on port 5555

  adb -d tcpip 5555
}

function acon() {
  # adb -d tcpip 5555
  # adb -d connect 192.168.1.$1:5555
  if [[ $# -eq 2 ]]; then
    # scrcpy -s 192.168.$1.$2:5555
    # adb -d connect 192.168.1.$1:5555
    adb connect 192.168.$1.$2:5555
  else;
    adb connect 192.168.1.$1:5555
  fi
}

#show on scrcpy immediately
function ashow() {
  adb -d tcpip 5555
  adb -d connect 192.168.1.$1:5555
  scrcpy -s 192.168.1.$1:5555
}

#what are my devices
function add() {
  adb devices
}

#install an apk
#adi <ip> blah.apk
function adi() {
  local usbMode=""
  local ip=""
  while getopts 'ds:' opt; do
    case "$opt" in
      d) usbMode="-d" ;;
      s) ip="192.168.1.$OPTARG:5555" ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d install $1
  elif [[ -n $ip ]]; then
    adb -s $ip install $1
  else;
    echo neither usbMode or ip given
  fi
}

#uninstall all argus apps
function adu() {
  for app in `adb shell pm list packages | rg argus`; do
    #download artifact for each job id
    adb uninstall $app
  done;
}


#what are the pids of the argus app?
function ads() {
  adb shell ps | rg argus
}

#pass a pid to logcat
function adll() {
  adb logcat --pid $1 -v time -v color
}
# ADB ==========================================================================

# logcat ==========================================================================
#run logcat immediately
# -a - which app d,s,p or fd,fs,fp
# -e - regex to search message
# -l - which log level v,d,i,w,e,f
# examples:
# adl -d - run logcat with cable
# adl -s 6 - run logcat, connect to 192.168.1.<6>
function adl() {
  local loglevel=v
  local regex=".*" #default
  local app=""
  local usbMode=""
  local ip=""
  #if -a app argument not given, get the pid of the first app named argus
  local appId="argus"

  while getopts 'l:e:a:ds:' opt; do
    case "$opt" in
      d) usbMode="-d" ;;
      l) loglevel=$OPTARG ;;
      e) regex=$OPTARG ;;
      s) ip="192.168.1.$OPTARG:5555" ;;
      a) app=$OPTARG
        case "$app" in
          d) appId="com.certis.argus.apps.officer.dev";;
          s) appId="com.certis.argus.apps.officer.staging";;
          p) appId="com.certis.argus.apps.officer$";; #prod - regex checks for end of string
          fd) appId="com.certisgroup.argus.apps.officer.dev";; #flutter dev
          fs) appId="com.certisgroup.argus.apps.officer.staging";; #flutter staging
          fp) appId="com.certisgroup.argus.apps.officer$";; #flutter prod
        esac
        ;;
    esac
  done
  shift $(($OPTIND - 1))

  local pid=""
  local appName=""
  # if length of usbMode is non-zero
  if [[ -n $usbMode ]]; then
    pid=$(adb -d shell ps | rg $appId | gawk 'NR==1{print $2}')
    appName=$(adb -d shell ps | rg $appId | gawk 'NR==1{print $9}')
  elif [[ -n $ip ]]; then
    pid=$(adb -s $ip shell ps | rg $appId | gawk 'NR==1{print $2}')
    appName=$(adb -s $ip shell ps | rg $appId | gawk 'NR==1{print $9}')
  else;
    echo "neither usbMode or ip was given, will leave it to the gods"
  fi

  echo connecting to app $appName
  echo with pid $pid
  echo with regex $regex
  echo usbMode: $usbMode
  echo ip: $ip

  if [[ -n $pid ]]; then
    if [[ -n $usbMode ]]; then
      adb $usbMode logcat "*:$loglevel" --pid $pid -v time -v color -e $regex
    elif [[ -n $ip ]]; then
      adb -s $ip logcat "*:$loglevel" --pid $pid -v time -v color -e $regex
    else;
      echo "neither usbMode or ip was given, not running command"
    fi
  else
    echo no pid found, not running command
  fi
  # adb $usbMode logcat
}
