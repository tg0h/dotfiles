
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

