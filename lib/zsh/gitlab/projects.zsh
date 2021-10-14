#get projects
#function ggpo() {
#  # get gitlab projects
#  # NOTE: ggp gets pipelines
#  #provide pipeline id
#  # -b prints the body only
#  #download job artifacts from argus officer flutter
#  https -b git.ads.certis.site/api/v4/projects "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" 
# }

function ggpo() {
  # TODO: how to eval https call to DRY
  # TODO: paginate
  # NOTE: keyset pagination not available
  
  # get gitlab projects
  # -b prints the body only
  # ggpo -v
  # ggpo -l
  # ggpo

  local long="" # long payload output
  local verbose="" # verbose httpie output
  local verbiage=""
  local oneline=""
  while getopts 'lv1' opt; do
    case "$opt" in
      l) long="true";;
      v) verbose="--verbose";;
      1) oneline="true";;

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
  [[ -n $long ]] && https -b git.ads.certis.site/api/v4/projects \
    "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN"

  [[ -n $verbose ]] && https --verbose git.ads.certis.site/api/v4/projects \
    "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN"

local jqQuery=$(cat <<-EOF
                    .[] |
                    {
                      build_coverage_regex,
                      path_with_namespace,
                      namespaceParent: .namespace.parent_id,
                      namespaceId: .namespace.id,
                      namespaceName: .namespace.name,
                      merge_method,
                      name,
                      web_url,
                      id,
                    }
EOF
)

  [[ -n $oneline ]] && https $verbiage git.ads.certis.site/api/v4/projects \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq -r '.[] | .namespace.name + " " + (.id|tostring) + " " + .name'

    #if short
  [[ -z "$long" ]] && [[ -z "$verbose" ]] && [[ -z "$oneline" ]] && https $verbiage git.ads.certis.site/api/v4/projects \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq $jqQuery

  }

