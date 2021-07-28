# TODO: acon should connect by device flag eg -y for the yellow phone
# TODO: global var for build folders
# TODO: add adb logcat -c to clear logcat

# SCRCPY ==========================================================================

function sc() {
  # sc -b - show blue phone
  # sc -g - show green phone
  # sc -r - show red phone
  # sc -y - show yellow phone
  # sc 18 123
  # sc 18

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
  while getopts 'bryc' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;
      c) ip=$HP_CALLTREE_IP ;;
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
function adc(){
  # clear the log buffer
  # EXAMPLES:
  # adc -r

  local ip=""
  #connectionMode is either -s or -d
  local connectionMode=""
  while getopts 'bryd' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;
      c) ip=$HP_CALLTREE_IP ;;
      d) connectionMode="-d"
    esac
  done
  shift $(($OPTIND - 1))

  [[ -n $ip ]] && connectionMode="-s"

  #clear the logcat buffer
  adb $connectionMode $ip logcat -c
}

function adg(){
  # show buffer size
  # EXAMPLES:
  # adg

  local ip=""
  #connectionMode is either -s or -d
  local connectionMode=""
  while getopts 'bryd' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;
      c) ip=$HP_CALLTREE_IP ;;
      d) connectionMode="-d"
    esac
  done
  shift $(($OPTIND - 1))

  [[ -n $ip ]] && connectionMode="-s"
  #clear the logcat buffer
  adb $connectionMode $ip logcat -g
}

#run logcat immediately
# -a - which app d,s,p or fd,fs,fp
# -e - regex to search message
# -l - which log level v,d,i,w,e,f
# -w - w for raw output do not filter for flutter
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
  # TODO: use adb shell pidof -s com.example.app to get the pid
  # TODO: test option to just show pid, app etc outputs without showing log
  local loglevel=v
  local regex=".*" #default
  local app=""
  local usbMode=""
  local ip=""
  #if -a app argument not given, get the pid of the first app named argus
  local appId="argus"

  local filter #filter used to filter log message
  local filterIsRaw #if this option is set, set the filter to an empty string

  while getopts 'bryl:e:a:dsw' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;

      s) ip="192.168.1.$OPTARG:5555" ;;

      d) usbMode="-d" ;;

      l) loglevel=$OPTARG ;;
      e) regex=$OPTARG ;;
      w) filterIsRaw=true;; #if raw option specified, show all log output
      a) app=$OPTARG
        case "$app" in
          d) appId="com.certis.argus.apps.officer.dev";;
          s) appId="com.certis.argus.apps.officer.staging";;
          p) appId="com.certis.argus.apps.officer$";; #prod - regex checks for end of string
          fd) appId="com.certisgroup.argus.apps.officer.dev";; #flutter dev
          fs) appId="com.certisgroup.argus.apps.officer.staging";; #flutter staging
          fp) appId="com.certisgroup.argus.apps.officer$";; #flutter prod
          cd) appId="com.certisgroup.cathy.debug";; #certify dev
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

  local appType

  # the globar variable contains a text file with a tag name and a log level.
  # each entry in the text file begins on a new line
  # eg tag1:S
  #    tag2:S
  # kotlinSilenceFilter then contains the string "tag1:S tag2:S", which silences
  # logs with these tags in the logcat output
  local kotlinSilenceFilter=$(cat $ARGUS_LOGCAT_FILTER_KOTLIN | tr '\n' ' ')

  ## double escape the \
  # https://stackoverflow.com/questions/61242119/matching-regex-not-working-properly-in-zsh
  # in zsh, you do not need to escape the .
  echo appName is ""$appName""
  if [[ $appName =~ '.cathy.' ]]; then
    appType=certify
    filter=""
  elif [[ $appName =~ '.certisgroup.' ]]; then
    appType=flutter
    # only show log messages with the flutter tag, silence other logs
    filter="flutter:V *:S"
  elif [[ $appName =~ '.certis.' ]]; then
    appType=kotlin
    filter="$kotlinSilenceFilter"
  fi

  if [[ -n $filterIsRaw ]]; then
    filter="" #do not filter the log message
  fi;


  echo connecting to app $appName
  echo "flutter app name -- com.certisgroup.argus.apps.officer.[env]"
  echo "sg app name      -- com.certis.argus.apps.officer[env]"
  echo -------
  echo appType is $appType
  echo using filter: $filter
  echo with pid: $pid
  echo with regex: $regex
  echo usbMode: $usbMode
  echo ip: $ip

  if [[ -n $pid ]]; then
    if [[ -n $usbMode ]]; then
      adb $usbMode logcat $filter --pid $pid -v time -v color -e $regex
    elif [[ -n $ip ]]; then
      adb -s $ip logcat $filter --pid $pid -v time -v color -e $regex
    else;
      echo "neither usbMode or ip was given, not running command"
    fi
  else
    echo no pid found, not running command
  fi
  # adb $usbMode logcat
}

alias adfk="vim $ARGUS_LOGCAT_FILTER_KOTLIN"
