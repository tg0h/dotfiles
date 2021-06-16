## AWS cloud watch rule management
function ctlist(){
  aws events list-rules | jq -r '.Rules[] | .Name'
}

function ctfilter(){
  aws events list-rules | jq -r '.Rules[] | .Name' | rg $1
}

# TODO: how to remove target and delete rule in a single function?
# delete the cloudwatch rule target before deleting it
# run ctfilter ... | ctdelt, then run
# run ctfilter ... | ctdelr
function ctdelt(){
  # examples:
  # ctfilter 2020 | ctdelt
  # ctfilter 202103 | ctdelt
  parallel aws events remove-targets --rule {} --ids 1
  # parallel aws events delete-rule --name {}
}

# delete the cloudwatch rule after deleting the cloudwatch rule target
function ctdelr(){
  # examples:
  # ctfilter 2020 | ctdelr
  # ctfilter 202103 | ctdelr
  # parallel aws events remove-targets --rule {} --ids 1
  # to use, run this command: ctfilter 2020 | ctdelr
  parallel aws events delete-rule --name {}
}

## Android pirate ship log management

function ctl(){
  # list log directory on pirate ship
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d shell ls -la sdcard/Download
  else;
    adb -s $ip shell ls -la sdcard/Download
  fi
}

function ctp(){
  # pull logs from pirate ship to current directory
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d pull sdcard/Download/call-tree-error.log
    adb -d pull sdcard/Download/call-tree-sms-delivery.log
  else;
    adb -s $ip pull sdcard/Download/call-tree-error.log
    adb -s $ip pull sdcard/Download/call-tree-sms-delivery.log
  fi
}

function ctd(){
  # delete logs on pirate ship
  # TODO: d same as delete?
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d shell rm sdcard/Download/call-tree-error.log
    adb -d shell rm sdcard/Download/call-tree-sms-delivery.log
  else;
    adb -s $ip shell rm sdcard/Download/call-tree-error.log
    adb -s $ip shell rm sdcard/Download/call-tree-sms-delivery.log
  fi

}
