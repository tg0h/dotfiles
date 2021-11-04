function rcs(){
  # redis cli set
  # ras <key> [expiry]
  local key=$1
  local value=$2
  local expiry=$3

  # suppress the ok output
  redis-cli set $key $value > /dev/null
  # [[ -n "$expiry" ]] && redis-cli expire $key $expiry
  redis-cli expire $key $expiry > /dev/null
}

function rcjs(){
  redis-cli json.set $1
}

