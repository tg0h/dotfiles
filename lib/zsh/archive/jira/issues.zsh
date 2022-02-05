function rai(){
  # get jira issue
  # rai 1234 gets rai ARG-1234

  local long comments

  while getopts 'lc' opt; do
    case "$opt" in
      l) long=true;;
      c) comments=true;;

      # a) app=$OPTARG
        #   case "$app" in
        #     A) appFilter="argus|cathy|titus|optimax" ;; # show all apps
        #   esac
        #   ;;
      esac
    done
    shift $(($OPTIND - 1))

    local ticket=$(https -b -a $JIRA_SECRET $JIRA_API_URL/agile/1.0/issue/ARG-$1)

    local jqQuery=$(cat <<-EOF
                               def rpad(\$len; \$fill): tostring | (\$len - length) as \$l | . + (\$fill * \$l)[:\$l];
                               def lpad(\$len; \$fill): tostring | (\$len - length) as \$l | (\$fill * \$l)[:\$l] + .;
                               { 
                                  "status": "\(.status)",
                                  "components": "\(.components)",
                                  "fixVersions": "\(.fixVersions)",
                                  "-------------------------------",
                                  "epic": "\(.epickey) - \(.epicname)",
                                  "parent": "\(.parent) - \(.parentSummary)",
                                  "ticket-status|time": "\(.key) - \(.issuetype) | \(.created[8:10])\(.created[5:7]) \(.created[11:16]) - \(.updated[8:10])\(.updated[5:7]) \(.updated[11:16])",
                                  "summary": .summary,
                                  "sprint|fixVersion": "\(.sprint // .closedSprint| rpad(15;" "))",
                                  "hLvl|isSub|parent": "\(.hierarchyLevel) | \(.isSubtask)",
                                  subtasks: .subtasks| map("\(.key) | \(.status) | \(.summary)"),
                                  people: "\(.creator) - \(.reporter) - \(.assignee)",
                                  links: .links | map("\(.rel | lpad(13;" ")): \(.key) | \(.status | rpad(5;" ")) | \(.type| rpad(8;" "))| \(.summary) "),
                                  git: .git | map("\(.created[8:10])-\(.created[5:7]) \(.created[11:16]) | \(.mention.mentionRef[0:7] | rpad(8;" ")) | \(.mention.appName | capture (".*/(?<appName>.*)") | .appName | rpad(23;" ")) | \(.mention.userName| rpad(20;" ")) | \(.mention.mentionDescription)"),
                                }
EOF
)

    if [[ -n "$long" ]]; then
      # display entire json response
      jq . <<< $ticket
    elif [[ -n "$comments" ]]; then
      # display raw comments from gitlab
      jq '.fields.comment.comments | map(select(.author.displayName == "AugmentTech DSFO") | .body)' <<< $ticket
    else
      # display pretty printed json response summary
      _rai $1 | jq $jqQuery 
      # heredoc redirects doc to cat input, unable to redirect directly into a variable
      # the hypen <<- allows you to indent your heredoc
      # not sure why # is allowed in the jqQuery ¯\_(ツ)_/¯
    fi
  }

function _rai(){
  local ticket=$(https -b -a $JIRA_SECRET $JIRA_API_URL/agile/1.0/issue/ARG-$1)

  local jqQuery=$(cat <<-EOF
                        {
                          sprint: .fields.sprint.name,
                          closedSprint: .fields.closedSprints[0]?.name,
                          key: .key,
                          summary: .fields.summary,
                          # components: .fields.components[0]?.name,
                          components: .fields.components | map (.name) | sort | join(", "),
                          epickey: .fields.epic.key,
                          epicname: .fields.epic.name,
                          parent: .fields.parent.key,
                          parentSummary: .fields.parent.fields.summary,
                          status: .fields.status.name,
                          created: .fields.created,
                          updated: .fields.updated,
                          points: .fields.customfield_10106,
                          # project (argus)
                          creator: .fields.creator.displayName,
                          reporter: .fields.reporter.displayName,
                          assignee: .fields.assignee.displayName,
                          issuetype: .fields.issuetype.name,
                          hierarchyLevel: .fields.issuetype.hierarchyLevel,
                          isSubtask: .fields.issuetype.subtask,
                          priority: .fields.priority.name,
                          labels: .fields.labels,
                          fixVersions: .fields.fixVersions | map (.name) | sort | join(", "),
                          url: .self,
                          # subtasks: (.fields.subtasks | map (.key) | reduce .[] as '$item' (""; . + " " + '$item')),
                          # subtasks: (.fields.subtasks | map (.key)),
                          subtasks: .fields.subtasks | map ({key: .key, summary: .fields.summary, status: .fields.status.name}),
                          links: (.fields.issuelinks | map(
                                                            {
                                                              rel: (if .inwardIssue then .type.inward else .type.outward end),
                                                              key: (.inwardIssue.key // .outwardIssue.key),
                                                              summary: (.inwardIssue.fields.summary //.outwardIssue.fields.summary),
                                                              status: (.inwardIssue.fields.status.name // .outwardIssue.fields.status.name),
                                                              type: (if .inwardIssue then "inward" else "outward" end)
                                                            }
                                                          )),
                          git: (.fields.comment.comments |
                                map(select(.author.displayName == "AugmentTech DSFO")) |
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
                          # for merge commit comments, look for author AugmentTech DSFO
                          # merge commit mentioned in .fields.comment.comments[n].body [Hanh Nguyen Han|https://git.ads.certis.site/hanh.nguyenhan] mentioned this issue in [a commit of optimax/optimax-apps/optimax-officer-android|https://git.ads.certis.site/optimax/optimax-apps/optimax-officer-android/-/commit/b27ff0a4c50b21444c10cef1aa0eb82c426ea727]:\n'Merge branch 'sprint-23/feature/ARG-2723/develop' into sprint-23/feature/ARG-2723/ARG-2879'
                        }
EOF
)
jq "$jqQuery" <<< $ticket

}
