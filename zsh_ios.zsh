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
  # while getopts 'l:e:a:ds:' opt; do
  #   case "$opt" in
  #     d) usbMode="-d" ;;
  #   esac
  # done
  # shift $(($OPTIND - 1))

  ideviceinstaller -n -i $1
}

# run logs
function idl() {
  # -n connect to network device
  # -p connect to process named Runner
  idevicesyslog -n -p Runner
}
