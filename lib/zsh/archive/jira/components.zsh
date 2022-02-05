function rapc(){
  # get jira project versions (releases)
  # name, id, released, archived, projectId
  # sort by version id descending
  # rapv - gets unreleased versions by default
  # rapv -n 100 - get 100 versions
  local filter result
  while getopts 'n:a' opt; do
    case "$opt" in
      # n) number=$OPTARG;;
      n) filter="| .[0:$OPTARG]";; # jq - get the first n elements of array
      a) filter="| .";; # jq - get all elements in array (no op)
    esac
  done
  shift $(($OPTIND - 1))

  # TODO: how to pass reload param to rcache?
  result=$(rcache 'jira/rapc.604800' '_rapc')

  # if filter is not defined (default case), then get unreleased project versions
  local filter=${filter:-"| map(select(.released != true))"}
  local jqQuery=$(cat <<-EOF
                include "colour";
                include "pad";

                def _(\$bool): (\$bool|tostring) | if . == "true" then _g("X") else __("-") end;

                # add a column header row
                # [ "name", "id", "issues" ] ,
                ( 
                  # sort_by(-(.id|tonumber), .name)
                  # | reverse
                  # | map(select(.released != true))
                  sort_by(.name)
                  # $filter
                  | .[] 
                  | [ .name, .id, .issueCount ] 
                ) 
                | @tsv
EOF
)
  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result \
    | column -ts $'\t'
  # jq --raw-output -L "~/.config/jq" . <<< $result
}

function _rapc(){
  # get jira project versions (releases)

  local outdir=$(mktemp -d '/tmp/jira.components.XXX')
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  local projectId=10759

  while [ $isLast = "false" ]; do
    resp=$(_jira_get_next_page "api/3/project/$projectId/component" $startAt)
    _jira_download_page "$resp" $outdir $page
    startAt=$(_jira_get_next_startAt $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)
  jq <<< $data
}
