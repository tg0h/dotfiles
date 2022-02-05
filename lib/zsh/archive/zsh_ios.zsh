# install ios ipa
# see https://libimobiledevice.org/

function idd() {
  idevice_id
}

function idn() {
  # while getopts 'l:e:a:ds:' opt; do
  #   case "$opt" in
  #     d) usbMode="-d" ;;
  #   esac
  # done
  # shift $(($OPTIND - 1))
  idevicename
}


function idi() {
  # iphone device installer
  # idi - install the latest ipa in this folder to the network phone
  # idi <ipa file name> - install the specified ipa
  # idid -i <ipa file name> - install


  # fd -d 1 - search with depth 1 (current dir only)
  # gsort -k1r - sort by the 1st column descending
  # head -n1 - get me the first row
  if [[ -z $1 ]]; then
    # local latestIpa=$(fd -d 1 './*.ipa' | gsort -k1r | head -n1)
    
    #ls -t sort by time
    #ls -p add trailing / to directories
    #rg -v / - invert match, find entries that do not have the '/' character
    #rg '.*apk' - get all entries with a .apk
    #get the 1st match
    local latestIpa=$(ls -tp | rg -v / | rg '.*ipa' | head -n1)
    ideviceinstaller -n -i $latestIpa
  else
    ideviceinstaller -n -i $1
  fi
}

# run logs
function idl() {
  # -n connect to network device
  # -p connect to process named Runner
  idevicesyslog -n -p Runner
}
