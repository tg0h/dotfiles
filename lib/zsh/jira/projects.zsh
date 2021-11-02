function rap(){
  # get jira projects
  # prettifies the data

  local result
  result=$(rcache "$@" 'jira/rap.604800' '_rap')

  # use , in jq to manually specify a column header
  local jqQuery='["id","name","key","style","projectTypeKey","simplified","isPrivate"] , (.[] | [ (.id|tostring) , .name , .key , .style , .projectTypeKey, .simplified, .isPrivate] ) | @tsv'
  # TODO: how to use heredoc to specify jq string?
  # local jQuery=$(cat <<-EOF
  #                   .[] | (.id|tostring) +  "-" + .name
  # EOF
  # )
  # echo $jQuery

  # https://unix.stackexchange.com/questions/57222/how-can-i-use-column-to-delimit-on-tabs-and-not-spaces
  # use $'\t' to specify c style tab characters
  # specifying '\t' causes column to separate on the \ and the t character
  # TODO: how to use rg to capture the header?
  jq --raw-output "$jqQuery" <<< $result \
    | column -ts $'\t' \
    | rg --color never -e id -e Argus -e Certify -e Optimax
}

function _rap(){
  # get jira projects
  # _rap gets the raw data

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

  local data=$(jq --null-input '[inputs| .values[]]' $outdir/*.json)

  jq <<< $data
}
