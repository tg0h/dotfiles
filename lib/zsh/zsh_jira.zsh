# https://docs.atlassian.com/jira-software/REST/7.3.1/
# https://docs.atlassian.com/software/jira/docs/api/REST/8.19.0
# $JIRA_URL is defined in zsh_jira.plug.zsh
# $JIRA_SECRET is defined in the env file

function f(){
  # f 2805 opens ARG-2805 in jira in firefox
  open -a firefox https://jira.ads.certis.site/browse/ARG-$1
}

function rab(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default

  # jq
  # -r - raw output
  https --print=HhBb -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board \
    | jq -r  '.values[] | (.id|tostring) + " - " + .name'
  }

function rae(){
  # get epics - TODO: add pagination
  # TODO: check the .isLast field and paginate
  # jq
  # when using sort_by, the input must be an array
  # sorts in ascending order, use reverse to reverse the sort
  # this gets the epic status which is independent of the epic ticket status ... zzzz
  local boardId=1 #Argus
  local raw
  while getopts 'r' opt; do
    case "$opt" in
      r) raw=true;;
    esac
  done
  shift $(($OPTIND - 1))

  local result=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/epic)
  if [[ -z $raw ]]; then
    jq -r '.values | sort_by(.id) | reverse | .[] | (.id|tostring) + " - " + .key + " - " + .name + " - " + (.done|tostring)' \
      <<< $result
  else
    jq <<< $result
  fi

}

function raei(){
  # get epics - TODO: add pagination
  # TODO: check the .isLast field and paginate
  # jq
  # when using sort_by, the input must be an array
  # sorts in ascending order, use reverse to reverse the sort
  # this gets the epic status which is independent of the epic ticket status ... zzzz
  local boardId=1 #Argus
  local raw
  local epicId
  while getopts 'ri:' opt; do
    case "$opt" in
      r) raw=true;;
      i) epicId=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  local result=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/epic/$epicId/issue)
  if [[ -z $raw ]]; then
    jq -r '.issues[] | .key + " - " + .fields.status.name + " - " + .fields.summary + " - " + .fields.assignee.displayName + " - " +  .fields.creator.displayName' \
      <<< $result
  else
    jq <<< $result
  fi

}
function ras(){
  local res=$(redis-cli get ras)
  # gotcha! - compare empty string, surround with quotes;
  if [[ -z "$res" ]] ; then
    res=$(_ras-api)
    redis-cli set ras $res > /dev/null #silence the OK
    redis-cli expire ras 604800 #1 week
  fi
  # ras-api
  _ras-view $res
}
_ras-view(){
  # notice that i use the [0:10] notation to substring the date
  jq -r '. | sort_by(.id) | reverse | .[] | (.id|tostring) + " - " + .name + " - " + (.startDate | .[0:10]) + " - " + (.endDate | .[0:10]) + " - " + (.completeDate | .[0:10])' <<< $1
}

_ras-api(){
  # call the api, paginate, store the results
  # return a non-pretty string of json (not json escaped)
  boardId=1 #Argus

  local result
  local startAt=0
  local maxResults
  local isLast=false
  
  # use single brackets for string equality test
  # else [[ ]] performs pattern matching
  mkdir -p /tmp/jira

  local i=0
  trash /tmp/jira/*.json
  while [ $isLast = "false" ]; do

    # to debug it is useful to reduce the number of items in the page
    # result=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/sprint'?'startAt=$startAt'&'maxResults=1)
    result=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/sprint'?'startAt=$startAt)
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
