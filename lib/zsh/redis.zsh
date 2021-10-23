alias rc="redis-cli"

function rcg(){
  # redis cli get
  redis-cli get $1
}

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

function rcd(){
  redis-cli del $1
}

function rce(){
  # redis-cli expire 
  # rce <key> <expiry in seconds>
  redis-cli expire $1 $2
}

function rcf(){
  redis-cli flushall
}

function rcjg(){
  redis-cli json.get
}

function rcjs(){
  redis-cli json.set
}

function rct(){
  # redis-cli ttl
  # rct <key>
  redis-cli ttl
}

function rcka(){
  # get all keys
 redis-cli keys '*'
}
