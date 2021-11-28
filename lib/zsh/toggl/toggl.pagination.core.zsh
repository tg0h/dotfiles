# pagination is used by the toggl detailed reports

function _toggl_download_page(){
  # download api results to json file in outDir
  local resp=$1
  local outdir=$2
  local page=$3

  echo $resp > $outdir/page${page}.json
}

function _toggl_get_next_page(){
  # https -b -a $JIRA_SECRET $JIRA_API_URL/$1'?'startAt=$2
  # $1 contains the toggl url and request params
  eval "https -b -a $TOGGL_API_KEY $1 $TOGGL_UA page==$2"
  # eval "https -b -a $TOGGL_API_KEY "$@""
}

function _toggl_isLastPage(){
  local length response=$1
  # TODO: this fails if the json response contains a newline
  # eg if the service desk ticket summary has a newline
  # jq complains with 'parse error: Invalid string: control characters from U+0000 through U+001F must be escaped at line 3, column 33'

  length=$(echo $response | jq '.data | length')


  # return an exit status of 1 (exception condition)
  # to tell calling function to exit the while loop
  # the calling function can detect the exit status by checking $?
  
  if [ $length -gt 0 ]; then
    return 0 # continue
  else
    return 1 # if length of data is 0 (we are at the last page), stop pagination
  fi
}
