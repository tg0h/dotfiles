function rapv(){
  # get jira project versions (releases)
  # name, id, released, archived, projectId
  # sort by version id descending
  # rapv - gets 20 versions by default
  # rapv -n 100 - get 100 versions
  local number all
  while getopts 'n:a' opt; do
    case "$opt" in
      n) number=$OPTARG;;
      a) all="| .";; # jq no op if all option passed
    esac
  done
  shift $(($OPTIND - 1))

  number=${number:-20}

  local result
  # TODO: how to pass reload param to rcache?
  result=$(rcache 'jira/rapv.604800' '_rapv')

  # if all is set, then pass all value (| .) (jq no op)
  local notReleasedFilter=${all:-"| map(select(.released != true))"}
  local jqQuery=$(cat <<-EOF
                include "colour";
                include "pad";

                def _(\$bool): (\$bool|tostring) | if . == "true" then _g("X") else __("-") end;

                # add a column header row
                [ "name","id",  __("R"), __("A"), __("start"), __("rel"), "description" ] ,
                ( 
                  sort_by(-(.id|tonumber), .name)
                  # | reverse
                  # | map(select(.released != true))
                  $notReleasedFilter
                  | .[] 
                  | [ .name, .id , _(.released), _(.archived) , __(.startDate[5:10]), __(.releaseDate[5:10]), .description ] 
                ) 
                | @tsv
EOF
)
  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result \
    | head -n $number \
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
