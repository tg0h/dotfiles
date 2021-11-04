function rcf(){
  redis-cli flushall
}

function rcd(){
  redis-cli del $1
}

function rcdj(){
  # redis cli delete jira keys
  redis-cli keys '/rest*' | xargs redis-cli DEL
}

function rce(){
  # redis-cli expire
  # rce <key> <expiry in seconds>
  redis-cli expire $1 $2
}

function rct(){
  # redis time to live
  # redis-cli ttl
  # rct <key>
  redis-cli ttl $1
}

