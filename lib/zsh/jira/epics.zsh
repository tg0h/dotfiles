# https://docs.atlassian.com/jira-software/REST/7.3.1/
# https://docs.atlassian.com/software/jira/docs/api/REST/8.19.0
# $JIRA_URL is defined in zsh_jira.plug.zsh
# $JIRA_SECRET is defined in the env file

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
  # get epics and their issues - TODO: add pagination
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
