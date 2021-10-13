function _gitlab_getLatestDevPipelineId() {
  https -b git.ads.certis.site/api/v4/projects/$GITLAB_PROJECT_ID/pipelines "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    jq '[.[] | select (.ref == "develop") ] | .[0].id'
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

function _gitlab_dlJobArtifact() {
  # download job artifacts
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



