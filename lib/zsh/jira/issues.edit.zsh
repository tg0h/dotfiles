# TODO: rich editing with atlassian document format

function raiem(){
  # get edit issue metadata
  # raiem -123
  # raiem -p OTXSC 1234 # searches for OTXSC-1234
  # https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-editmeta-get
  
  local prefix

  while getopts 'p:' opt; do
    case "$opt" in
      p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  prefix="${prefix:-ARG}"

  rapir /issue/$prefix-$1/editmeta
}

function raie(){
  # edit ticket fields
  # raie 3106
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

  flabel=$(jo add=fault)
  echo $flabel
  labels=$(jo -a $flabel)
  echo $labels
  update=$(jo labels=$labels)
  echo $update
  echo this is labels $labels

  # fVersions=$(jo -p -d. "fixVersions[]=$(jo -d. add.name='argus cc au 1.23-au')")
  # fVersions=$(jo -d. add.name='argus cc au 1.23-au')

  # update=$(jo -d. "labels=$labels fixVersions[]=$fVersions")
  # echo this is update $update
  # echo $fVersions

  # rapir /issue/$prefix-$1/transitions
  https --verbose -a $JIRA_SECRET PUT $JIRA_API_URL/api/3/issue/$prefix-$1 \
    update:=$update
}
