function tod(){
  # toggl detailed report
  # -w : workspace, defaults to certis. accepts
  #      c - certis
  #      s - study
  #      h - hacking
  #      m - home
  # -d : provide a description to search for entries
  # -s : since date. accepts 'yyyy-mm-dd'. defaults to -6 days
  # -u : until date. accepts 'yyyy-mm-dd'. defaults to today
  # -j : specify json format
  #
  # examples:
  # tod -wc
  # tod -s '2021-11-28'
  # tod -d <search string>

  local ws workspace=3861113 page=1 since description result format unt

  while getopts 'w:s:u:d:p:j' opt; do
    case "$opt" in
      w) ws="$OPTARG"
      case "$ws" in
        c) workspace=3861113;;
        s) workspace=1335456;;
        h) workspace=5265641;;
        m) workspace=4858804;;
      esac ;;
      d) description="$OPTARG";;
      s) since=$OPTARG;;
      u) unt=$OPTARG;;
      p) page=$OPTARG;;
      j) format="json";;
    esac
  done
  shift $(($OPTIND - 1))

  description=${description:+description==$description}
  since=${since:+since==$since}
  unt=${unt:+until==$unt}
  workspace="workspace_id==$workspace"
  page="page==$page"

  # eval "https -b -a $TOGGL_API_KEY $TOGGL_API_REPORTS/details $TOGGL_UA $workspace $description $since $page"
  # TODO: spaces are added even if var is empty, eg ' '$var1' '$var2
  local httpArgs="$workspace $description $since $unt"


  result=$(rcache "toggl/tod.$httpArgs.604800" "_tod" "$httpArgs")
  local jqQuery=$(cat <<-EOF
                  include "toggl";
                  .[]
                  # | "\(.client) \(.project) - \(.description)" 
                  # | {client, project, description, start, end, dur, tags}
                  | [ .client, .project, .description, (.start|tdate), (.end|tdate), (.dur| thm)]
                  # | [ .client, .project, .description ]
                  | @tsv
EOF
)
  [ "$format" = "json" ] && jqQuery="."

  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result \
    | column -ts $'\t'
}

function _tod(){
  # passThrough args are passed to toggl get next page
  local httpArgs="$TOGGL_API_REPORTS/details $TOGGL_UA $@"

  local outdir=$(mktemp -d '/tmp/toggl.detailedReport.XXX')
  local page=1
  local isLast="false"
  local resp=""

  local projectId=10759

  while true; do
    resp=$(_toggl_get_next_page "$httpArgs" $page)
    _toggl_download_page "$resp" $outdir $page
    $(_toggl_isLastPage $resp)
    # if the return status of _toggl_isLastPage is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .data[]]' $outdir/*.json)
  jq <<< $data
}
