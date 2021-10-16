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

function _ggpo(){
  # paginate and get all projects
   # local outdir=$(mktemp -d)
  # local outdir=/tmp/test

  trash /tmp/gitlabProjects/*
  mkdir -p /tmp/gitlabProjects
  local outdir=/tmp/gitlabProjects
  local page=1
  local nextUrl=https://git.ads.certis.site/api/v4/projects

  while [ ! -z "${nextUrl}" ]; do
    https -dh $nextUrl PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN per_page==100  > $outdir/page${page}.json 2>$outdir/header

    # sample link: Link: <https://git.ads.certis.site/api/v4/projects?membership=false&order_by=created_at&owned=false&page=2&per_page=100&simple=false&sort=desc&starred=false&statistics=false&with_custom_attributes=false&with_issues_enabled=false&with_merge_requests_enabled=false>; rel="next",
    # use tr to split the link at < and >
    nextUrl=$(cat $outdir/header | tr '<,' '\n' | rg next | tr '>' '\n' | head -n 1)
    page=$(( $page + 1 ))
  done

  local allProjects=$(jq -n '[inputs| .[]]' $outdir/*.json)
  jq -r 'tostring' <<< $allProjects

}
