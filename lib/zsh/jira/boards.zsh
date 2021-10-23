function _jira_download_page(){
  # download api results to json file in outDir
  # local resp=$1
  # local outdir=$2
  # local page=$3

  echo $resp > $outdir/page${page}.json
}

function _jira_get_next_page(){
  # get the next page from the jira api
  # pass api url path with $1
  # pass the startAt index with $2
  https -b -a $JIRA_SECRET $JIRA_API_URL/$1'?'startAt=$2
}

function _jira_get_next_startAt(){
  local response=$1

  maxResults=$(echo $response | jq '.maxResults')
  startAt=$(echo $response | jq '.startAt')
  isLast=$(echo $response | jq '.isLast')

  echo $(( startAt + maxResults ))

  # return an exit status of 1 (exception condition)
  # to tell calling function to exit the while loop
  # the caling function can detect the exit status by checking
  # $?
  if [ "$isLast" = "true" ]; then
    return 1
  else
    return 0
  fi
}
function rab(){
  # get jira boards from cache
  local key="jira/rab"
  local val=$(rcg $key)
  if [[ -z "$val" ]]; then
    val=$(_rab)
    rcs $key $val 604800 #1 week in seconds
  fi
  echo $val
}

function _rab(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default

  local outdir=$(mktemp -d /tmp/jira.boards.XXX)
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  while [ $isLast = "false" ]; do
    resp=$(_jira_get_next_page board $startAt)
    _jira_download_page "$resp" $outdir $page
    startAt=$(_jira_get_next_startAt $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local allBoards=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)
  local jqQuery='.[] | (.id|tostring) + " - " + .name'

  jq --raw-output $jqQuery <<< $allBoards | sort -r -V 
}
