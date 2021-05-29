# TODO: acon should connect by device flag eg -y for the yellow phone
# TODO: global var for build folders

# SCRCPY ==========================================================================

function sc() {
  # sc -b - show blue phone
  # sc -g - show green phone
  # sc -r - show red phone
  # sc -y - show yellow phone
  # sc 18 123
  # sc 18

  local ip=""
  while getopts 'bgry' opt; do
    case "$opt" in
      # d) usbMode="-d" ;;
      # s) ip="192.168.1.$OPTARG:5555" ;;
      b) ip="192.168.1.48:5555" ;;
      g) ip="192.168.1.6:5555" ;;
      r) ip="192.168.1.19:5555" ;;
      y) ip="192.168.1.189:5555" ;;
    esac
  done
  shift $(($OPTIND - 1))
 
  if [[ -n $ip ]]; then
    scrcpy -s $ip --window-x 129 --window-y 427 --window-width 355 --window-height 782
  elif [[ $# -eq 2 ]]; then
    scrcpy -s 192.168.$1.$2:5555 --window-x 129 --window-y 427 --window-width 355 --window-height 782
  else
    scrcpy -s 192.168.1.$1:5555 --window-x 129 --window-y 427 --window-width 355 --window-height 782
  fi
}

function sca() {
  #always on top
  # sca -b - show blue phone
  # sca -g - show green phone
  # sca -r - show red phone
  # sca -y - show yellow phone
  # sca 18 123
  # sca 18

  local ip=""
  while getopts 'bgry' opt; do
    case "$opt" in
      # d) usbMode="-d" ;;
      # s) ip="192.168.1.$OPTARG:5555" ;;
      b) ip="192.168.1.58:5555" ;;
      g) ip="192.168.1.6:5555" ;;
      r) ip="192.168.1.19:5555" ;;
      y) ip="192.168.1.189:5555" ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $ip ]]; then
    scrcpy -s $ip --always-on-top --window-x 129 --window-y 427 --window-width 355 --window-height 782 &
  elif [[ $# -eq 2 ]]; then
    scrcpy -s 192.168.$1.$2:5555 --always-on-top --window-x 129 --window-y 427 --window-width 355 --window-height 782 &
  else
    scrcpy -s 192.168.1.$1:5555 --always-on-top --window-x 129 --window-y 427 --window-width 355 --window-height 782 &
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
  local ip=""
  while getopts 'bgry' opt; do
    case "$opt" in
      b) ip="192.168.1.58:5555" ;;
      g) ip="192.168.1.6:5555" ;;
      r) ip="192.168.1.19:5555" ;;
      y) ip="192.168.1.189:5555" ;;
    esac
  done
  shift $(($OPTIND - 1))

  # adb -d tcpip 5555
  # adb -d connect 192.168.1.$1:5555
  if [[ -n $ip ]]; then
    adb connect $ip
  elif [[ $# -eq 2 ]]; then
    # scrcpy -s 192.168.$1.$2:5555
    # adb -d connect 192.168.1.$1:5555
    echo connecting to 192.168.$1.$2:5555
    adb connect 192.168.$1.$2:5555
  else;
    echo connecting to 192.168.1.$1:5555
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
# SENSIBLE DEFAULTS:
# if no apk provided, install the latest apk in the current folder
# TODO: if just adi - default to common case - adi -r?

#TODO: support 2 ip groups, eg 192.168.xxx.yyy
#TODO: if ip not found, run adb connect first

#EXAMPLES: 
# adi -s 19 <apk name> - adb -s 192.168.1.19 <apk name>
# adi -r <apk name> - install to the red phone's ip
# if <apk name> not provided, get the latest apk in current folder. Latest as defined by ls -t

  local usbMode=""
  local ip=""
  while getopts 'bdgrs:y' opt; do
    case "$opt" in
      b) ip="192.168.1.58:5555" ;;
      d) usbMode="-d" ;;
      g) ip="192.168.1.6:5555" ;;
      r) ip="192.168.1.19:5555" ;;
      s) ip="192.168.1.$OPTARG:5555" ;;
      y) ip="192.168.1.189:5555" ;;
    esac
  done
  shift $(($OPTIND - 1))

  local apkFileName=""
  #if $1 is not provided
  if [[ -z $1 ]]; then
    #fd -d 1 - use fd to search in current directory only
    #gsort -k1r - sort by 1st column descending
    #head -n1 - get the 1st row
    # apkFileName=$(fd -d 1 './*.apk' | gsort -k1r | head -n1)
    
    #ls -t sort by time
    #ls -p add trailing / to directories
    #rg -v / - invert match, find entries that do not have the '/' character
    #rg '.*apk' - get all entries with a .apk
    #get the 1st match
    apkFileName=$(ls -tp | rg -v / | rg '.*apk$' | head -n1)
  else
    apkFileName=$1
  fi

  echo "going to install $apkFileName ..."

  if [[ -n $usbMode ]]; then
    adb -d install $apkFileName &
  elif [[ -n $ip ]]; then
    # -g grants all permissions specified in the app manifest
    echo "granting all permissions to $apkFileName ..."
    adb -s $ip install -g --fastdeploy $apkFileName &
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
# device flags to specify id quickly
# -r = red phone
# -y = yellow phone
# -g = green phone
# -b = blue phone
# examples:
# adl -d - run logcat with cable
# adl -s 6 - run logcat, connect to 192.168.1.<6>
# adl -r - debug on the red phone
function adl() {
  local loglevel=v
  local regex=".*" #default
  local app=""
  local usbMode=""
  local ip=""
  #if -a app argument not given, get the pid of the first app named argus
  local appId="argus"

  while getopts 'bgryl:e:a:ds:' opt; do
    case "$opt" in
      b) ip="192.168.1.58:5555" ;;
      g) ip="192.168.1.6:5555" ;;
      r) ip="192.168.1.19:5555" ;;
      y) ip="192.168.1.189:5555" ;;

      s) ip="192.168.1.$OPTARG:5555" ;;

      d) usbMode="-d" ;;

      l) loglevel=$OPTARG ;;
      e) regex=$OPTARG ;;
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
  echo "flutter app name -- com.certisgroup.argus.apps.officer.[env]"
  echo "sg app name      -- com.certis.argus.apps.officer[env]"
  echo -------
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
