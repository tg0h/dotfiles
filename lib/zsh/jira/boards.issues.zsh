function rabi(){
  # get jira boards
  local result boardId sprintId
  boardId=$1
  sprintId=$2

  result=$(rcache "$@" jira/rabi.604800 _rabi $boardId $sprintId)
  echo $result
}

function _rabi(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default
  local boardId sprintId
  boardId=$1
  sprintId=$2
  # echo $boardId
  # echo $boardId

  local outdir=$(mktemp -d /tmp/jira.boards.issues.XXX)
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  while [ $isLast = "false" ]; do
    resp=$(_jira_get_next_page "agile/1.0/board/$boardId/sprint/$sprintId/issue" $startAt)
    _jira_download_page "$resp" $outdir $page
    startAt=$(_jira_get_next_startAt $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  # local data=$(jq --null-input '[inputs| .issues[]]' $outdir/*.json)
  # local jqQuery='.[] | (.id|tostring) + " - " + .name'
  echo $data

  jq --raw-output <<< $data
}
