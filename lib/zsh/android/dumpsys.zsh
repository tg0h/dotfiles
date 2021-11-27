function ads(){
  # adb shell dumpsys packageName

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
  local appId=argus # default - look for any argus app if no app specified in -a
  while getopts 'bryda:' opt; do
    case "$opt" in
      b) ip=$HP_BLUE_IP;;
      r) ip=$HP_RED_IP ;;
      y) ip=$HP_YELLOW_IP ;;

      d) usbMode="-d" ;;

      a) app=$OPTARG
        case "$app" in
          d) appId="com.certis.argus.apps.officer.dev";;
          s) appId="com.certis.argus.apps.officer.staging";;
          p) appId="com.certis.argus.apps.officer$";; #prod - regex checks for end of string
          fd) appId="com.certisgroup.argus.apps.officer.dev";; #flutter dev
          fs) appId="com.certisgroup.argus.apps.officer.staging";; #flutter staging
          fp) appId="com.certisgroup.argus.apps.officer$";; #flutter prod
          cd) appId="com.certisgroup.cathy.debug";; #certify dev
          od) appId="tech.augment.optimax.officer.dev";;
          os) appId="tech.augment.optimax.officer.staging";;
          op) appId="tech.augment.optimax.officer";;
          *) echo 'app not found'
             return 1
            ;;
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

  # detect package name if no app specified by -a 
  # default get the first argus app found
  if [[ -n $usbMode ]]; then
    pid=$(adb -d shell ps | rg $appId | gawk 'NR==1{print $2}')
    appName=$(adb -d shell ps | rg $appId | gawk 'NR==1{print $9}')
  elif [[ -n $ip ]]; then
    pid=$(adb -s $ip shell ps | rg $appId | gawk 'NR==1{print $2}')
    appName=$(adb -s $ip shell ps | rg $appId | gawk 'NR==1{print $9}')
  else;
    echo "neither usbMode or ip was given, will leave it to the gods"
  fi

  # if cannot find appName via adb shell ps, then use the appId specified in -a option
  appName=${appName:-appId}

  echo dumping package $appName
  echo "flutter app name -- com.certisgroup.argus.apps.officer.[env]"
  echo "sg app name      -- com.certis.argus.apps.officer[env]"
  echo -------
  # echo with pid: $pid
  echo usbMode: $usbMode
  echo ip: $ip
  adb $usbMode $sOPT $ip shell dumpsys package $appName
}

