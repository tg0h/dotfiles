function rait(){
  # jira issue transition
  # rait <transitionId> ticketId1 ticketId2 ... - transition ticket ids with transitionId
  # get transition ids with raitm <ticketId>
  # -p - specify a ticket prefix
  # https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-transitions-get
  
  local prefix transition statusId

  while getopts 'p:' opt; do
    case "$opt" in
      p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  prefix="${prefix:-ARG}"
  statusId=$1
  transition=$(jo id=$1)

  shift # pop argv so that only ticket args remain in $@

  for ticket in "$@"; do
    echo transitioning ticket $fg[yellow]"$prefix-$ticket"$reset_color to status $fg[yellow]$statusId$reset_color
  # rapir /issue/$prefix-$1/transitions
    https -b -a $JIRA_SECRET POST $JIRA_API_URL/api/3/issue/$prefix-$ticket/transitions \
      transition:=$transition \
      | gawk '{$1=$1;print}' #trim whitespace
  # https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
  done;
}

function raitm(){
  # get issue transitions metadata
  # display transitions for ticket
  # sort output with sort -t\| -k3 (escape | with \)
    local jqQuery=$(cat <<-EOF
                               def rpad(\$len; \$fill): tostring | (\$len - length) as \$l | . + (\$fill * \$l)[:\$l];
                               def lpad(\$len; \$fill): tostring | (\$len - length) as \$l | (\$fill * \$l)[:\$l] + .;
                               .transitions |
                               # the additional data on the right is irrelevant
                               # map ("\(.id | lpad(5;" ")) \(.name| rpad(17;" ")) | \(.to.id | lpad(5;" ")) \(.to.name | rpad(18; " ")) | \(.to.statusCategory.name)") |
                               map ("\(.id | lpad(5;" ")) \(.name| rpad(17;" "))") |
                               .[]
EOF
)

  _raitm $1 | jq --raw-output $jqQuery
}

function _raitm(){
  # get jira status issue transitions
  # raiet 3106
  # raiem -p OTXSC 1234 # searches for OTXSC-1234
  # https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-transitions-get
  
  local prefix

  while getopts 'p:' opt; do
    case "$opt" in
      p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  prefix="${prefix:-ARG}"

  # rapir /issue/$prefix-$1/transitions
  https -b -a $JIRA_SECRET $JIRA_API_URL/api/3/issue/$prefix-$1/transitions \
}

