function rapvd(){
  # delete a project version
  local versionId=$1

  # local tmpfile=$(mktemp -d /tmp/httpie.XXX)/response.json

  # https --download --headers --pretty all -a $JIRA_SECRET POST \
  #   $JIRA_API_URL/api/3/version/$versionId/removeAndSwap <<< '{}' > test 2> timtest

  # https --download --headers -a $JIRA_SECRET POST \
  #   $JIRA_API_URL/api/3/version/$versionId/removeAndSwap <<< '{}' \
  #   2>&1 
  
  https -phb -a $JIRA_SECRET POST $JIRA_API_URL/api/3/version/$versionId/removeAndSwap <<< '{}'

  # [ -f $tmpfile ] && jq . $tmpfile
}
