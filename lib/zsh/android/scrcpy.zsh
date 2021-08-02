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

#show on scrcpy immediately
function ashow() {
  adb -d tcpip 5555
  adb -d connect 192.168.1.$1:5555
  scrcpy -s 192.168.1.$1:5555
}
