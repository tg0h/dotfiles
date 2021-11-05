function rait(){
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

function raitm(){
    local jqQuery=$(cat <<-EOF
                               def rpad(\$len; \$fill): tostring | (\$len - length) as \$l | . + (\$fill * \$l)[:\$l];
                               def lpad(\$len; \$fill): tostring | (\$len - length) as \$l | (\$fill * \$l)[:\$l] + .;
                               .transitions |
                               map ("\(.id | lpad(5;" ")) \(.name| rpad(17;" ")) | \(.to.id | lpad(5;" ")) \(.to.name | rpad(18; " ")) | \(.to.statusCategory.name)") |
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

