function rapvi(){
  # get issues in fixVersion
  # rapvi <fixVersionId|fixVersionName>
  # rapvi 10601 - use the fixVersion Id
  # rapvi 'Optimax\ CC\ 1.2.3' - escape the spaces so that rcache can evaluate the arg
  local fixVersion

  fixVersion="$1"

  shift # remove $1 so we do not pass it to rcache

  result=$(rcache "$@" "jira/rapvi/$fixVersion.604800" _rapvi "$fixVersion")

  local jqQuery=$(cat <<-EOF
                               include "pad";
                               include "gitlab";
                               # def rpad(\$len; \$fill): tostring | (\$len - length) as \$l | . + (\$fill * \$l)[:\$l];
                               # def lpad(\$len; \$fill): tostring | (\$len - length) as \$l | (\$fill * \$l)[:\$l] + .;
                               .[]  |
                               "\(.key ) | \(.fields.issuetype.name | rp(8)) | \(.fields.status.name | gStatus) | \(.fields.assignee.displayName | gName) | \(.fields.summary) "
EOF
)
  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result

}

function _rapvi(){
  # get issues in fixVersion
  local fixVersion="$1" # surround with double quotes since $1 may contain spaces

  local outdir=$(mktemp -d /tmp/jira.projectVersion.issues.XXX)
  local page=1
  local isLast="false"
  local startAt=0
  local resp=""

  while [ $isLast = "false" ]; do
    resp=$(https -a $JIRA_SECRET $JIRA_API_URL/api/3/search \
      startAt==$startAt \
      jql=='project="Argus" and fixVersion="'"$fixVersion"'"' \
      fields=='issuetype,status,assignee,summary') # limit the fields that are returned, if not some special characters may break jq

    _jira_download_page "$resp" $outdir $page

    startAt=$(_jira_get_next_startAt $resp)
    # if the return status of _jira_get_next_startAt is 1, exit the while loop
    [ $? -eq 1 ] && break;
    (( page++ ))
  done

  local data=$(jq --null-input '[inputs| .issues[]]' $outdir/*.json)

  jq --raw-output <<< $data
}
