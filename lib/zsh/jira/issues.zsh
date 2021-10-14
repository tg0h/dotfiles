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
                          git: (.fields.comment.comments | 
                                map(select(.author.name == "certis.ads")) |
                                map(
                                      {
                                      created,
                                      mention: .body |
                                              # jq uses the oniguruma regex engine https://github.com/kkos/oniguruma/blob/master/doc/RE
                                              # to escape a word class, eg \w, use \\w
                                              # however, since we are running this from a terminal, we need to escape again.
                                              # hence \\ becomes \\\\ . fun
                                              # +? is non greedy it matches conservatively until it finds the next expression
                                              # eg (.+?)(|) if there are several pipes | in the string, the nongreedy expression matches
                                              # everything until the first pipe. the greedy expression matches everything until the last pipe.
                                              # (?<group>(exp) is a jq named capturing group


                                              # capture("(\\\\[)(?<name>.+?)(\\\\|)(.+?)(\\\\|)(?<url>.+?)(\\\\])") | .url,
                                              capture("\\\\[(?<userName>.*?)\\\\|(?<userUrl>.*?)].*\\\\[a (?<mentionType>.*?) of(?<appName>.*?)\\\\|(?<mentionUrl>.*?)](?<test>:\n')(?<mentionDescription>.*)'") |
                                              {
                                                userName, 
                                                # userUrl,
                                                mentionType,
                                                appName,
                                                mentionUrl,
                                                # parse the mentionUrl string https://git.ads.certis.site/optimax/optimax-apps/optimax-officer-android/-/commit/b27ff0a4c50b21444c10cef1aa0eb82c426ea727
                                                # ?= is positive lookahead match but don't capture
                                                # appUrl: (.mentionUrl | match("https.*(?=/-)")| .string), 
                                                # ?<= is negative look behind
                                                # mentionTypeSlug: (.mentionUrl | match("(?<=-/).*?(?=/)") | .string), 
                                                # ?! is negative look behind. the ?! expression should not match
                                                # in other words, get the last "segment" which follows after the last / in "https://blah/foo/segment"
                                                mentionRef: (.mentionUrl | match("(?!.*/).*$") | .string), 
                                                mentionDescription
                                              },
                                      }
                                   )
                               ),
                          # for merge commit comments, look for author certis.ads
                          # merge commit mentioned in .fields.comment.comments[n].body [Hanh Nguyen Han|https://git.ads.certis.site/hanh.nguyenhan] mentioned this issue in [a commit of optimax/optimax-apps/optimax-officer-android|https://git.ads.certis.site/optimax/optimax-apps/optimax-officer-android/-/commit/b27ff0a4c50b21444c10cef1aa0eb82c426ea727]:\n'Merge branch 'sprint-23/feature/ARG-2723/develop' into sprint-23/feature/ARG-2723/ARG-2879'
                        }
EOF
)
      jq "$jqQuery" <<< $ticket
    fi
  }

function raib(){
  # get jira issue brief
  # rai 1234 gets rai ARG-1234
      # heredoc redirects doc to cat input, unable to redirect directly into a variable
      # the hypen <<- allows you to indent your heredoc
      # not sure why # is allowed in the jqQuery ¯\_(ツ)_/¯
    local ticket=$(https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/issue/ARG-$1)

      local jqQuery=$(cat <<-EOF
                        {
                          key: .key,
                          summary: .fields.summary,
                          sprint: .fields.sprint.name,
                          components: .fields.components[0]?.name,
                          epicname: .fields.epic.name,
                          status: .fields.status.name,
                          created: .fields.created,
                          reporter: .fields.reporter.name, 
                          assignee: .fields.assignee.name,
                          git: (.fields.comment.comments | 
                                map(select(.author.name == "certis.ads")) |
                                map(
                                      {
                                      created,
                                      mention: .body |
                                              capture("\\\\[(?<userName>.*?)\\\\|(?<userUrl>.*?)].*\\\\[a (?<mentionType>.*?) of(?<appName>.*?)\\\\|(?<mentionUrl>.*?)](?<test>:\n')(?<mentionDescription>.*)'") |
                                              {
                                                userName, 
                                                mentionUrl,
                                                mentionRef: (.mentionUrl | match("(?!.*/).*$") | .string), 
                                                mentionDescription
                                              },
                                      }
                                   )
                               ),
                        }
EOF
)
      jq "$jqQuery" <<< $ticket
  }

