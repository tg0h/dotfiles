function ads(){
  # adb shell dumpsys packageName
  # list installed packages on phone
  # ads -d -a <app> - get the package info of <app> for the phone connected via usb

  local sOPT
  local usbMode
  local appId
  local appSearchId appSearchString="argus"
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
    appSearchId=$(adb -d shell ps | rg $appSearchString | gawk 'NR==1{print $9}')
  elif [[ -n $ip ]]; then
    appSearchId=$(adb -s $ip shell ps | rg $appSearchString | gawk 'NR==1{print $9}')
  else;
    echo "neither usbMode or ip was given, will leave it to the gods"
  fi

  # if no appId was provided with the -a option, then search for any running argus app
  appId=${appId:-appSearchId}

  echo dumping package $appId
  echo "flutter app name -- com.certisgroup.argus.apps.officer.[env]"
  echo "sg app name      -- com.certis.argus.apps.officer[env]"
  echo -------
  # echo with pid: $pid
  echo usbMode: $usbMode
  echo ip: $ip
  echo appId: $appId
  adb $usbMode $sOPT $ip shell dumpsys package $appId
}

