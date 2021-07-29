# TODO: acon should connect by device flag eg -y for the yellow phone
# TODO: global var for build folders
# TODO: add adb logcat -c to clear logcat

# TODO: get app userid 
# adb -d shell dumpsys package com.certis.argus.apps.officer.dev | rg userId


# ADB ==========================================================================

function adp() {
  # get screenshots, etc from phone
  # gets the ip of the phone connected via usb
  # Camera
  # Screenshots
  # Videocaptures
  adb -d pull /sdcard/DCIM/screenshots
}

function adls() {
  # list installed packages on phone
  #
  # gets the ip of the phone connected via usb
  # ls screenshots, etc from phone
  # Camera
  # Screenshots
  # Videocaptures
  # adb -d shell ls /sdcard/DCIM/screenshots

  local sOPT
  local usbMode
  local appFilter="argus"
  while getopts 'bryda:' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;

      d) usbMode="-d" ;;

      a) app=$OPTARG
        case "$app" in
          a) appFilter="argus" ;;
          c) appFilter="cathy" ;; # certify
          t) appFilter="titus" ;; # certify
          *) appFilter=".*" ;; # show all apps
        esac
        ;;
    esac
  done
  shift $(($OPTIND - 1))


  if [[ -n $usbMode ]]; then
    # do nothing
  elif [[ -n $ip ]]; then
    sOPT="-s"
  else
    echo neither usbMode or ip given
    return 1
  fi

  # adb shell pm list packages outputs a list of packages with a package:<package name> prefix
  # remove the package: prefix with choose
  # echo usbMode: $usbMode
  # echo sOPT: $sOPT
  # echo ip: $ip
  # pm is the package manager
  adb $usbMode $sOPT $ip shell pm list packages | rg $appFilter | choose -f ':' 1
}


function adr() {
  # remove screenshots from phone
  # gets the ip of the phone connected via usb
  # Camera
  # Screenshots
  # Videocaptures
  # -r - recursive
  adb -d shell rm -r /sdcard/DCIM/screenshots
}



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
  while getopts 'bryc' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;
      c) ip=$HP_CALLTREE_IP ;;
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
  # TODO: add acon and atcp here

#TODO: support 2 ip groups, eg 192.168.xxx.yyy
#TODO: if ip not found, run adb connect first

#EXAMPLES:
# adi -s 19 <apk name> - adb -s 192.168.1.19 <apk name>
# adi -r <apk name> - install to the red phone's ip
# if <apk name> not provided, get the latest apk in current folder. Latest as defined by ls -t

local usbMode=""
local ip=""
local g="-g" # grant all permissions by default
while getopts 'bdrs:yG' opt; do
  case "$opt" in
    d) usbMode="-d" ;;
    s) ip="192.168.1.$OPTARG:5555" ;;
    b) ip=$HP_BLUE_IP;;
    r) ip=$HP_RED_IP ;;
    y) ip=$HP_YELLOW_IP ;;
    G)  g="" ;;
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
  # if $g is empty, then we are granting all permissions when installing
  # [[ -z $g ]] &&
  echo "granting all permissions to $apkFileName ..."
  adb -s $ip install -g --fastdeploy $apkFileName &
else;
  echo neither usbMode or ip given
fi
}

#uninstall all argus apps
function adu() {

  local usbMode=""
  local ip=""
  local appId="argus"

  while getopts 'bryd' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;

      d) usbMode="-d" ;;

      a) app=$OPTARG
        case "$app" in
          a) appId="argus" ;;
          c) appId="cathy" ;; # certify
          # d) appId="com.certis.argus.apps.officer.dev";;
          # s) appId="com.certis.argus.apps.officer.staging";;
          # p) appId="com.certis.argus.apps.officer$";; #prod - regex checks for end of string
          # fd) appId="com.certisgroup.argus.apps.officer.dev";; #flutter dev
          # fs) appId="com.certisgroup.argus.apps.officer.staging";; #flutter staging
          # fp) appId="com.certisgroup.argus.apps.officer$";; #flutter prod
          # cd) appId="com.certisgroup.cathy.debug";; #certify dev
        esac
        ;;
    esac
  done
  shift $(($OPTIND - 1))

  local listPkgcmd=""

  if [[ -n $usbMode ]]; then
    # do nothing
  elif [[ -n $ip ]]; then
    local sOPT="-s"
    local ipOpt="$ip"
    # local ipOPT="-s $ip" # this doesn't work?? ¯\_(ツ)_/¯
  else
    echo neither usbMode or ip given
    return 1
  fi

  # adb shell pm list packages outputs a list of packages with a package:<package name> prefix
  # remove the package: prefix with choose
  # echo $usbMode
  # echo $sOPT
  # echo $ip
  local apps=$(adb $usbMode $sOPT $ip shell pm list packages | rg $appId | choose -f ':' 1)

  echo $fg[yellow] trying to delete $appId apps
  # for app in "adb $usbMode shell pm list packages | rg argus"; do
  if [[ -z $apps ]]; then
    echo $fg[yellow] no $appId apps found
  else
    for app in $apps ; do
      # adb uninstall $app
      # echo $app
      echo $fg[yellow] uninstalling $app
      adb $usbMode $sOPT $ip uninstall --user 0 $app
    done;
  fi
}


##what are the pids of the argus app?
#function ads() {
#  adb shell ps | rg argus
#}

