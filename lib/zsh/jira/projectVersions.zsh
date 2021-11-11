function rapv(){
  # get jira project versions (releases)
  # name, id, released, archived, projectId
  # sort by version id descending
  # rapv - gets 20 versions by default
  # rapv -n 100 - get 100 versions
  local number
  while getopts 'n:' opt; do
    case "$opt" in
      n) number=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  number=${number:-20}

  local result
  # TODO: how to pass reload param to rcache?
  result=$(rcache 'jira/rapv.604800' '_rapv')
  # local jqQuery='["name","id","released","archived","projectId"] , (.[] | [ .name, (.id|tostring), .released, .archived , .projectId ] ) | @tsv'
  local jqQuery='(.[] | [ .name, (.id|tostring), .released, .archived , .projectId ] ) | @tsv'
  jq --raw-output $jqQuery <<< $result \
    | sort -t$'\t' -k2r | head -n $number | sort -t$'\t' -k1 \
    | column -ts $'\t'
}

function _rapv(){
  # get jira project versions (releases)

  local outdir=$(mktemp -d '/tmp/jira.projectVersions.XXX')
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  local projectId=10759

  while [ $isLast = "false" ]; do
    resp=$(_jira_get_next_page "api/3/project/$projectId/version" $startAt)
    _jira_download_page "$resp" $outdir $page
    startAt=$(_jira_get_next_startAt $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)
  jq <<< $data
}
