function ggc() {
  # get gitlab commits
  # https://docs.gitlab.com/ee/api/
  #
  # TODO: use headers to paginate request

  https --verbose $GITLAB_URL/projects/$GITLAB_PROJECT_ID/repository/commits/ \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN \
    all==true \
    pagination==keyset \
    per_page==2 \
  }

function ggcr() {
  # gitlab Commit Refs - IMPORTANT
  # get branches/tags commit is pushed to
  # ggcr <commit sha>
  
  # column -t separates columns with tabs

  https -b $GITLAB_URL/projects/$GITLAB_PROJECT_ID/repository/commits/$1/refs \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN \
    | jq -r '.[] | .name +" "+ .type' | column -t
  }

function ggcm() {
  # gitlab Commit Mrs 
  # get merge requests related to commit
  # ggcm <commit sha>

  local long="" # long payload output
  local verbose="" # verbose httpie output
  local verbiage=""
  while getopts 'lv' opt; do
    case "$opt" in
      l) long=true;;
      v) verbose="--verbose";;

      # a) app=$OPTARG
        #   case "$app" in
        #     A) appFilter="argus|cathy|titus|optimax" ;; # show all apps
        #   esac
        #   ;;
      esac
    done
    shift $(($OPTIND - 1))

    # use variable expansion ${var:-default}
    # null coalese the verbose variables
    # if verbose, then verbose, else body
    
    # -b is the body option for http
    verbiage=${verbose:-"-b"}
    
    #if long 
  [[ -n $long ]] && https $verbiage $GITLAB_URL/projects/$GITLAB_PROJECT_ID/repository/commits/$1/merge_requests \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN

local jqQuery=$(cat <<-EOF
                    .[] |
                    {
                      state,
                      author: .author.username,
                      assignee: .assignee.username,
                      created_at,
                      title,
                      description,
                      # force_remove_source_branch,
                      # should_remove_source_branch,
                      # merge_when_pipeline_succeeds,
                      # has_conflicts,
                      # merge_status,
                      merge_commit_sha,
                      merged_at,
                      merged_by: .merged_by.username,
                      squash,
                      squash_commit_sha,
                      # work_in_progress,
                      # closed_at,
                      # closed_by,
                      # updated_at,
                    }
EOF
)

    #if short
  [[ -z $long ]] && https $verbiage $GITLAB_URL/projects/$GITLAB_PROJECT_ID/repository/commits/$1/merge_requests \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq $jqQuery

  }

