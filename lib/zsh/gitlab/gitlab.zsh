# TODO: show local timezone for ggp command
function _setGitlabProj() {
  # export the command so that processes (eg app center cli commands) forked from
  # your terminal session inherit the GITLAB_PROJECT_ID variable
  case $1 in
    a) export GITLAB_PROJECT_ID=80
      echo Argus Kotlin
      ;;
    f) export GITLAB_PROJECT_ID=202
      echo Argus Flutter
      ;;
    o) export GITLAB_PROJECT_ID=229
      echo Optimax Android
      ;;
    oc) export GITLAB_PROJECT_ID=231
      echo Optimax CC
      ;;
    c) export GITLAB_PROJECT_ID=118
      echo Argus CC
      ;;
    t) export GITLAB_PROJECT_ID=223
      echo My Gitlab Test Project
      ;;
  esac
}

function gsp () {
  # gitlab switch profile
  # a - argus kotlin
  # f - argus flutter
  # o - optimax
  # c - cc
  # oc - optimax cc
  # t - argus cc test

  if [[ -z "$1" ]]
  then
    [[ $GITLAB_PROJECT_ID == 80 ]] && echo Argus Android
    [[ $GITLAB_PROJECT_ID == 202 ]] && echo Argus Flutter
    [[ $GITLAB_PROJECT_ID == 118 ]] && echo Argus CC
    [[ $GITLAB_PROJECT_ID == 223 ]] && echo My Gitlab Test Project
    [[ $GITLAB_PROJECT_ID == 229 ]] && echo Optimax Android
    [[ $GITLAB_PROJECT_ID == 231 ]] && echo Optimax CC
    return
  fi

  _setGitlabProj $1
}

function ggp() {
  # EXAMPLES:
  # ggp # default get 20 rows
  # ggp -n 40 # maximum of 100 rows
  # ggp -l  # long format, get 40 rows
  local rows=20
  while getopts 'n:l' opt; do
    case "$opt" in
      n) rows=$OPTARG ;;
      l) rows=40 ;;
    esac
  done
  shift $(($OPTIND - 1))
  # -b prints the body only
  # jq -r -- print raw output without double quotes
  #download job artifacts from argus officer flutter
  https -b "git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/pipelines?per_page=$rows" "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    # jq '.[0:19][] | select(.status =="success") | {id,"ref create_at": (.ref + " - " + .created_at)}'
      # jq -r '.[0:19][] | select(.status =="success") | ((.id|tostring) + " - " + .ref + " - " + .created_at)'
      jq -r '.[] | ((.id|tostring) + " - " + .ref + " - " + .created_at + " - " + .status)'
    }

#download job artifacts, given a pipeline id
function ggd() {
  #examples:
  # ggd
  #  download the latest build artifacts from the develop branch
  #
  # ggd <pipelineId>
  #  given a pipelineId, download its job artifacts

  # while getopts 'bdgrs:y' opt; do
  #   case "$opt" in
  #     b) ip="192.168.1.48:5555" ;;
  #     d) usbMode="-d" ;;
  #     g) ip="192.168.1.6:5555" ;;
  #     r) ip="192.168.1.19:5555" ;;
  #     s) ip="192.168.1.$OPTARG:5555" ;;
  #     y) ip="192.168.1.188:5555" ;;
  #   esac
  # done
  # shift $(($OPTIND - 1))

  local pipelineId=""
  if [ $# -eq 0 ]; then
    #if no args given, then get latest dev build
    pipelineId=$(_gitlab_getLatestDevPipelineId)
  else
    pipelineId=$1
  fi

  echo "downloading from pipeline id $pipelineId ..."

  for i in `_gitlab_getPipelineJobIds $pipelineId`; do
    #download artifact for each job id
    _gitlab_dlJobArtifact $i
  done;
}

#get projects
function _ggproj() {
  #provide pipeline id
  # -b prints the body only
  #download job artifacts from argus officer flutter
  https -b git.ads.certis.site/api/v4/projects "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" 
 }

#get pipeline jobs
function ggpj() {
  # TODO: support downloading job log output
  # https://docs.gitlab.com/ee/api/jobs.html
  
  #provide pipeline id
  # -b prints the body only
  #download job artifacts from argus officer flutter
  https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/pipelines/$1/jobs "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    jq '.[] | {"id": ((.id|tostring) + " - " + .status),"stage name ref": (.stage + " - " + .name + " - " + .ref + " - " + .created_at), "user": (.user.name + " - " + .commit.message), "fileformat": .artifacts[0].file_format}'
  }


function _gitlab_getLatestDevPipelineId() {
  https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/pipelines "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    jq '[.[] | select (.ref == "develop") ] | .[0].id'
  }

#download job artifacts
function _gitlab_dlJobArtifact() {
  # use a random filename so that filename does not collide with multiple background jobs
  # -p creates directories only if it does not exist
  local gitlabTmpFolder='/tmp/myGitlabZips'
  mkdir -p $gitlabTmpFolder
  local rnd=$RANDOM
  local filename="$gitlabTmpFolder/$rnd.zip"
  # echo $filename
  # -b prints the body only

  # unzip -j unzips all files into current directory
  # unzip -o overwrites files without prompting
  # unzip -d - ouotput directory
  # unzip -q - quietly unzip
  # (https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/jobs/$1/artifacts "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
  #   > $filename && unzip -jo $filename ) &
  
  # fd .apk <folder> - find apk files in this folder
  # rg -v app-debug - v means invert match - exclude  app-debug.apk
  # finally, cp the good apk file to the current folder
  (https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/jobs/$1/artifacts "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
    > $filename && unzip -q $filename -d $gitlabTmpFolder/$rnd && fd .apk $gitlabTmpFolder/$rnd | rg -v app-debug | xargs -I{} cp {} . \
    && echo pipeline $1 downloaded
    ) &
  # echo $filename unzipped
  }

function _gitlab_getPipelineJobIds() {
  #TODO repo id is hardcoded to officer flutter
  #get job ids only if they have a .zip artifact
  https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/pipelines/$1/jobs "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
    | jq --compact-output '.[] | select (.artifacts_file.filename|tostring | endswith("zip")) | .id'
  }



# function ggddd(){
#   # read the function def into a variable
#   local FUNCS=$(functions ggd)

#   # xargs is unable to see the zsh function
#   # use zsh -c as a messy workaround
#   ggdd $1 | xargs -I{} zsh -c "eval $FUNCS; ggd {}"
# }
