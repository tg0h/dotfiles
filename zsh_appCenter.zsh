## switch profile
function _setAppCenterApp() {
  local appCenter_app
  # export the command so that processes (eg app center cli commands) forked from
  # your terminal session inherit the MOBILE_CENTER_CURRENT_APP variable
  case $1 in
    is) export MOBILE_CENTER_CURRENT_APP="certis/Argus-Officer-staging" #argus ios staging
      echo Argus iOS Staging
      ;;
    ip) export MOBILE_CENTER_CURRENT_APP="certis/Argus-Officer" #argus ios flutter
      echo Argus iOS Production
      ;;
    as) export MOBILE_CENTER_CURRENT_APP="certis/Argus-Officer-staging-1" #argus android staging
      echo Argus Android Staging
      ;;
    ap) export MOBILE_CENTER_CURRENT_APP="***REMOVED***" #argus android flutter
      echo Argus Android Production
      ;;
  esac
}

acp () {
  if [[ -z "$1" ]]
  then
    [[ $MOBILE_CENTER_CURRENT_APP == "certis/Argus-Officer-staging" ]] && echo Argus iOS Staging
    [[ $MOBILE_CENTER_CURRENT_APP == "certis/Argus-Officer" ]] && echo Argus iOS  Production
    [[ $MOBILE_CENTER_CURRENT_APP == "certis/Argus-Officer-staging-1" ]] && echo Argus Android Staging
    [[ $MOBILE_CENTER_CURRENT_APP == "***REMOVED***" ]] && echo Argus Android Production
    return
  fi

  _setAppCenterApp $1
}

function acal() {
  #apps list
  appcenter apps list
}

function acl() {
  # EXAMPLES:
  # acl - get the latest 10 releases
  # acl -n 20 - get the latest 20 releases
  # acl -s - silent, do not print the current app

  #apps list
  # appcenter distribute releases list
  #
  # jq wizadry
  # - sort_by takes an array and sorts it (ascending)
  # reverse reverses the array elements to simulate sort descending
  # map takes an array. map (.name) means to perform .name on every array element
  # thus transforming the array. Essentially, this says reduce the array, i only
  # want the .name property of each array element
  # join takes an array and combines each array element in the array

  local n=10
  # there are no booleans in shell scripting. use an empty value to represent false
  local silent=false
  while getopts 'n:s' opt; do
    case "$opt" in
      n) n=$OPTARG ;;
      s) silent= ;;
    esac
  done

  #if silent is empty (true), then print current app with acp
  ! [[ -z $silent ]] && acp

  appcenter distribute releases list --output json | jq --raw-output 'sort_by(.uploadedAt) | reverse | .[0:'$n'][] | ((.id|tostring) + " -" + .shortVersion + " version:" + .version + " uploadAt: " + .uploadedAt + " enabled: " + (.enabled|tostring)) + " distGroups:" + (.distributionGroups | map(.name) | join(",")) + " destinations:" + (.destinations | map(.name) | join(","))'
}

function acll {
  # EXAMPLES:
  # acll - get the latest 5 releases for each app

  acp as
  acl -n 5 -s # call with -s silent option to stop acl from printing current app
  echo

  acp ap
  acl -n 5 -s

  echo
  acp is
  acl -n 5 -s

  echo
  acp ip
  acl -n 5 -s
}


function acd() {
  #apps download

  local id
  while getopts 'i:' opt; do
    case "$opt" in
      i) id=$OPTARG ;;
    esac
  done

  if [[ -n $id ]]; then
    appcenter distribute groups download --group Collaborators --id $id
  else;
    appcenter distribute groups download --group Collaborators
  fi
}

function acg() {
  # app center add GROUP

  # add the Public destination group to the release so that it is publically
  # available for download

  # EXAMPLES:
  # acg - make the latest release publically availble
  # acr -i <releaseId> - specify a release id to make publically available


  local id
  id=$(_appCenter_getLatestReleaseId)

  while getopts 'i:' opt; do
    case "$opt" in
      i) id=$OPTARG ;;
    esac
  done

  appcenter distribute releases add-destination --destination Public --type group --release-id $id --debug
}

function _appCenter_getLatestReleaseId () {
  appcenter distribute releases list --output json | jq 'sort_by(.uploadedAt) | reverse | .[0].id'
}

