function rap(){
  # get all jira projects
  https -b -a $JIRA_SECRET $JIRA_URL/api/3/project/search
}

function rap(){
  # get jira projects
  local result
  result=$(rcache "$@" 'jira/rap.604800' '_rap')
  echo $result
}

function _rap(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default

  local outdir=$(mktemp -d '/tmp/jira.projects.XXX')
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  while [ $isLast = "false" ]; do
    resp=$(_jira_get_next_page 'api/3/project/search' $startAt)
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
