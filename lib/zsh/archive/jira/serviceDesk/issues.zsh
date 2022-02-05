function sdqi(){
  # get service desk queue issues
  # sdqi -o - get all issues from the optimax 'all' queue
  # sdqi -a - get all issues from the argus 'all' queue

  local serviceDeskId queueId result

  while getopts 'oa' opt; do
    case "$opt" in
      o) 
        serviceDeskId=37 # optimax service desk
        queueId=338 # get the 'all' queue
        ;;
      a) 
        serviceDeskId=23
        queueId=340 # get the 'all' queue
        ;; # argus service desk
    esac
  done
  shift $(($OPTIND - 1))

  result=$(rcache "$@" jira/sdqi/$serviceDeskId:$queueId.604800 _sdqi $serviceDeskId $queueId)

  local jqQuery=$(cat <<-EOF
                      include "pad";
                      .[] |
                      "\(.key | rpad(8;" ")) | \(.fields.issuetype.name[0:8] | rpad(8;" ")) | \( .fields.created[0:10]) | \(.fields.resolutiondate[0:10] | rpad(10;" ")) | \(.fields.status.name[0:10] | rpad(10;" ")) |  \(.fields.reporter.displayName[0:10] | rpad(10;" ")) | \(.fields.assignee.displayName[0:10] | rpad(10;" ")) | \(.fields.summary[0:80])"
EOF
)

  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result
  # echo $result
}

function _sdqi(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default
  local serviceDeskId=$1
  local queueId=$2

  local outdir=$(mktemp -d /tmp/jira.serviceDesk.queues.issues.XXX)
  local page=1
  local isLastPage="false"
  local start=0
  local resp=""

  while [ $isLastPage = "false" ]; do
    # if you echo output here, it will be stored in the redis cache :| if you call sdqi
    # echo getting page $page with start: $start
    resp=$(_jira_sd_get_next_page "servicedeskapi/servicedesk/$serviceDeskId/queue/$queueId/issue" $start)
    _jira_download_page "$resp" $outdir $page
    start=$(_jira_sd_get_next_start $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)

  jq . <<< $data
}
