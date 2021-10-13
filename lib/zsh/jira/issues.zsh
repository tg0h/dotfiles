function rai(){
  # get jira issue
  # rai 1234 gets rai ARG-1234

  local long # full details
  while getopts 'l' opt; do
    case "$opt" in
      l) long=true;;

      # a) app=$OPTARG
        #   case "$app" in
        #     A) appFilter="argus|cathy|titus|optimax" ;; # show all apps
        #   esac
        #   ;;
      esac
    done
    shift $(($OPTIND - 1))

    local ticket=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/issue/ARG-$1)

    if [[ -n "$long" ]]; then
      jq . <<< $ticket
    else
      # heredoc redirects doc to cat input, unable to redirect directly into a variable
      # the hypen <<- allows you to indent your heredoc
      # not sure why # is allowed in the jqQuery ¯\_(ツ)_/¯
      local jqQuery=$(cat <<-EOF
                        {
                          sprint: .fields.sprint.name,
                          key: .key,
                          summary: .fields.summary,
                          components: .fields.components[0]?.name,
                          epickey: .fields.epic.key,
                          epicname: .fields.epic.name,
                          parent: .fields.parent.key,
                          parentSummary: .fields.parent.fields.summary,
                          status: .fields.status.name,
                          created: .fields.created,
                          updated: .fields.updated,
                          points: .fields.customfield_10106,
                          # project (argus)
                          # issuelinks
                          # subtasks
                          creator: .fields.creator.name, 
                          reporter: .fields.reporter.name, 
                          assignee: .fields.assignee.name,
                          issuetype: .fields.issuetype.name,
                          isSubtask: .fields.issuetype.subtask,
                          priority: .fields.priority.name,
                          labels: .fields.labels,
                          fixVersions: .fields.fixVersions[0]?.name,
                          url: .self,
                          # subtasks: (.fields.subtasks | map (.key) | reduce .[] as '$item' (""; . + " " + '$item')),
                          subtasks: (.fields.subtasks | map (.key)),
                          # for merge commit comments, look for author certis.ads
                          # merge commit mentioned in .fields.comment.comments[n].body [Hanh Nguyen Han|https://git.ads.certis.site/hanh.nguyenhan] mentioned this issue in [a commit of optimax/optimax-apps/optimax-officer-android|https://git.ads.certis.site/optimax/optimax-apps/optimax-officer-android/-/commit/b27ff0a4c50b21444c10cef1aa0eb82c426ea727]:\n'Merge branch 'sprint-23/feature/ARG-2723/develop' into sprint-23/feature/ARG-2723/ARG-2879'
                        }
EOF
)
      jq "$jqQuery" <<< $ticket
    fi
  }
