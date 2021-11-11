# function _jira_sd_download_page(){
#   # download api results to json file in outDir
#   # local resp=$1
#   # local outdir=$2
#   # local page=$3

#   echo $resp > $outdir/page${page}.json
# }

function _jira_sd_get_next_page(){
  # get the next page from the jira api
  # pass api url path with $1
  # pass the startAt index with $2
  https -b -a $JIRA_SECRET $JIRA_API_URL/$1'?'start=$2
}

function _jira_sd_get_next_start(){
  # https://docs.atlassian.com/jira-software/REST/7.3.1/
  # https://docs.atlassian.com/jira-servicedesk/REST/3.6.2/#pagination
  # note that pagination for jira rest and jira service desk rest is different
  local response=$1
  local start maxResults isLastPage limit

  # TODO: this fails if the json response contains a newline
  # eg if the service desk ticket summary has a newline
  # jq complains with 'parse error: Invalid string: control characters from U+0000 through U+001F must be escaped at line 3, column 33'
  limit=$(echo $response | jq '.limit')
  start=$(echo $response | jq '.start')
  isLastPage=$(echo $response | jq '.isLastPage')

  echo $(( start + limit ))

  # return an exit status of 1 (exception condition)
  # to tell calling function to exit the while loop
  # the calling function can detect the exit status by checking
  # $?
  if [ "$isLastPage" = "true" ]; then
    return 1
  else
    return 0
  fi
}

