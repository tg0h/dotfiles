function rait(){
  # jira issue transition
  
  # Examples
  # rait 11 3106 3129 - move ticket ARG-3106 and ARG-3129 with transition 11
  # rait -p OTXSC 11 3106 3129 - move tickets OTXSC-3106 and OTXSC-3129 with transition 11
  # cat <file> | rait 11 - rait accepts input via stdin - the file contains tickets ARG-3106, ARG-3129 on each row
  
  # Usage
  # rait <transitionId> ticketId1 ticketId2 ... - transition ticket ids with transitionId
  # get transition ids with raitm <ticketId>
  # -p - specify a ticket prefix

  # 11 To Do
  # 21 In Progress
  # 41 Unit Test
  # 61 Won't Fix
  # 251 Integration Test
  # 71 Regression Test
  # 291 Done
  # 301 Pending
  # 141 Start Work
  # https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-transitions-get

  local pipe prefix transition statusId tickets

  if [[ -p /dev/stdin ]]
  then
    pipe=$(cat -)
    # echo "PIPE=$PIPE"
  fi

  while getopts 'p:n' opt; do
    case "$opt" in
      p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  prefix="${prefix:-ARG}"- # add trailing - to prefix, eg ARG- in ARG-1234
  statusId=$1
  transition=$(jo id=$1)

  shift # pop argv so that only ticket args remain in $@

  tickets=${pipe:-$@} # get from pipe, else get from args

  # what does ${=tickets} do? - zsh does not split on word unlike bash, use the
  # = param expansion flag to enable this
  # https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion
  # https://stackoverflow.com/questions/68930203/loop-over-space-separated-string-in-zsh
  for ticket in ${=tickets}; do
    if [[ $ticket == *-* ]]; then  # use globbing to detect substring -
      prefix=""
    else
    fi
    echo moving ticket $fg[yellow]"$prefix$ticket"$reset_color to status $fg[yellow]$statusId$reset_color
    # rapir /issue/$prefix-$1/transitions
    https --ignore-stdin -b -a $JIRA_SECRET POST $JIRA_API_URL/api/3/issue/$prefix$ticket/transitions \
      transition:=$transition | jq .
          # use jq to strip the empty json response body from httpie which takes up several blank rows
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

