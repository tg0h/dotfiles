function ggmr() {
  # get gitlab merge request
  # get merge requests related to commit
  # ggmr <mr #>

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
  [[ -n $long ]] && https $verbiage $GITLAB_URL/api/v4/projects/$GITLAB_PROJECT_ID/merge_requests/$1 \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN

local jqQuery=$(cat <<-EOF
                    {
                      iid,
                      source_branch,
                      target_branch,
                      state,
                      title,
                      sha,
                      created_at,
                      has_conflicts,
                      force_remove_source_branch,
                      merge_when_pipeline_succeeds,
                      merge_status,
                      merge_error,
                      merge_commit_sha,
                      merged_at,
                      merged_by: .merged_by.name,
                      squash,
                      squash_commit_sha,
                      description,
                      project_id,
                      work_in_progress,
                      diff_refs,
                      createdBy: .head_pipeline.user.name,
                      pipelineCoverage: .head_pipeline.coverage,
                      pipelineStartedAt_: .head_pipeline.started_at,
                      pipelineFinishedAt: .head_pipeline.finished_at,
                      pipelineDuration: .head_pipeline.duration,
                      pipelineStatus: .head_pipeline.status,
                      pipelineBeforeSha: .head_pipeline.before_sha,
                      pipelineSha: .head_pipeline.sha,
                      pipelineTag: .head_pipeline.tag,
                      pipelineUrl: .head_pipeline.web_url,
                      first_deployed_to_production_at,
                    }
EOF
)

    #if short
  [[ -z $long ]] && https $verbiage $GITLAB_URL/api/v4/projects/$GITLAB_PROJECT_ID/merge_requests/$1 \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq $jqQuery

  }

