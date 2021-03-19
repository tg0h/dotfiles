function ggp() {
  # -b prints the body only
  # jq -r -- print raw output without double quotes
  #download job artifacts from argus officer flutter
  https -b git.ads.certis.site/api/v4/projects/202/pipelines "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    # jq '.[0:19][] | select(.status =="success") | {id,"ref create_at": (.ref + " - " + .created_at)}'
      # jq -r '.[0:19][] | select(.status =="success") | ((.id|tostring) + " - " + .ref + " - " + .created_at)'
      jq -r '.[] | ((.id|tostring) + " - " + .ref + " - " + .created_at + " - " + .status)'
    }

#download job artifacts, given a pipeline id
function ggd() {
  for i in `_gitlab_getPipelineJobIds $1`; do
    #download artifact for each job id
    _gitlab_dlJobArtifact $i
  done;
}

#get pipeline jobs
function ggpj() {
  #provide pipeline id
  # -b prints the body only
  #download job artifacts from argus officer flutter
  https -b git.ads.certis.site/api/v4/projects/202/pipelines/$1/jobs "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" | \
    jq '.[] | {"id": ((.id|tostring) + " - " + .status),"stage name ref": (.stage + " - " + .name + " - " + .ref + " - " + .created_at), "user": (.user.name + " - " + .commit.message), "fileformat": .artifacts[0].file_format}'
  }


#download job artifacts
function _gitlab_dlJobArtifact() {
  # use a random filename so that filename does not collide with multiple background jobs
  # -p creates directories only if it does not exist
  mkdir -p '/tmp/myGitlabZips/'
  local filename="/tmp/myGitlabZips/$RANDOM.zip"
  echo $1
  # echo $filename
  # -b prints the body only

  # unzip -j unzips all files into current directory
  # unzip -o overwrites files without prompting
  (https -b git.ads.certis.site/api/v4/projects/202/jobs/$1/artifacts "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
    > $filename && unzip -jo $filename ) &
  }

function _gitlab_getPipelineJobIds() {
  #TODO repo id is hardcoded to officer flutter
  #get job ids only if they have a .zip artifact
  https -b git.ads.certis.site/api/v4/projects/202/pipelines/$1/jobs "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
    | jq --compact-output '.[] | select (.artifacts_file.filename|tostring | endswith("zip")) | .id'
  }



# function ggddd(){
#   # read the function def into a variable
#   local FUNCS=$(functions ggd)

#   # xargs is unable to see the zsh function
#   # use zsh -c as a messy workaround
#   ggdd $1 | xargs -I{} zsh -c "eval $FUNCS; ggd {}"
# }
