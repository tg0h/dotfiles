function ras(){
  # get jira sprints
  # ras
  # ras -r - reload the cache (force an api call)
  local result
  # 1 week expiry
  # do not use getopts, pass through $ to rcache
  # getopts is too much code for passthrough
  result=$(rcache "$@" jira/ras.604800 _ras)
  _ras-view "$result"
}
_ras-view(){
  # notice that i use the [0:10] notation to substring the date
  jq -r '. | sort_by(.id) | reverse | .[] | (.id|tostring) + " - " + .name + " - " + (.startDate | .[0:10]) + " - " + (.endDate | .[0:10]) + " - " + (.completeDate | .[0:10])' <<< $1
}

_ras(){
  # call the api, paginate, store the results
  # return a non-pretty string of json (not json escaped)
  boardId=244 #Argus

  local result
  local startAt=0
  local maxResults
  local isLast=false

  # use single brackets for string equality test
  # else [[ ]] performs pattern matching
  mkdir -p /tmp/jira

  local i=0
  while [ $isLast = "false" ]; do

    # to debug it is useful to reduce the number of items in the page
    # result=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/sprint'?'startAt=$startAt'&'maxResults=1)
    result=$(https -b -a $JIRA_SECRET $JIRA_API_URL/agile/1.0/board/$boardId/sprint'?'startAt=$startAt)
    echo $result >/tmp/jira/$i.json

    maxResults=$(echo $result | jq '.maxResults')
    startAt=$(echo $result | jq '.startAt')
    isLast=$(echo $result | jq '.isLast')

    # echo maxResults: $maxResults
    # echo startAt: $startAt
    # echo isLast: $isLast
    # start at is zero based
    startAt=$(( startAt + maxResults ))
    # echo this is startAt now $startAt

    ((i++))
  done

  # inputs contains each json object passed in via the glob to jq
  local allResults=$(jq -n '[inputs | .values[]]' /tmp/jira/*.json)
  jq -r 'tostring' <<< $allResults

  # echo $allResults
  # local allResultsString=$(jq -r 'tostring' <<<$allResults)
  # redis-cli set tim $allResultsString
}
