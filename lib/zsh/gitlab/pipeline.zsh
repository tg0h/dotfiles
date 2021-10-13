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



