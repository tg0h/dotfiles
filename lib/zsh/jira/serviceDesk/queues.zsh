function sdq(){
  # get service desk queues
  # sdq -o - get optimax queues
  # sdq -a - get argus queues

  local serviceDeskId result

  while getopts 'oa' opt; do
    case "$opt" in
      o) serviceDeskId=37;; # optimax service desk
      a) serviceDeskId=23;; # argus service desk
    esac
  done
  shift $(($OPTIND - 1))

  result=$(rcache "$@" jira/sdq/$serviceDeskId.604800 _sdq $serviceDeskId)

  local jqQuery=$(cat <<-EOF
                      include "pad";
                      .[] |
                      "\(.id) | \( .name | rpad(20;" ") ) | \(.jql)"
EOF
)

  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result
}

function _sdq(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default
  local serviceDeskId=$1

  local outdir=$(mktemp -d /tmp/jira.serviceDesk.queues.XXX)
  local page=1
  local isLastPage="false"
  local start=0
  local resp=""

  while [ $isLastPage = "false" ]; do
    resp=$(_jira_sd_get_next_page "servicedeskapi/servicedesk/$serviceDeskId/queue" $start)
    _jira_download_page "$resp" $outdir $page
    start=$(_jira_sd_get_next_start $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)

  jq . <<< $data
}

