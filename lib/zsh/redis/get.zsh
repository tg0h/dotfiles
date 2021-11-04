function rcg(){
  # redis cli get
  redis-cli get $1
}

function rcjg(){
  redis-cli json.get $1
}

function rcka(){
  # get all keys
  redis-cli keys '*'
}

function rckj(){
  # get all jira keys
  redis-cli keys '/rest*'
}
