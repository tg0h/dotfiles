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
  [[ -n $long ]] && https -b $GITLAB_URL/api/v4/projects \
    "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN"

  [[ -n $verbose ]] && https --verbose $GITLAB_URL/api/v4/projects \
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

  [[ -n $oneline ]] && https $verbiage $GITLAB_URL/api/v4/projects \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq -r '.[] | .namespace.name + " " + (.id|tostring) + " " + .name'

    #if short
  [[ -z "$long" ]] && [[ -z "$verbose" ]] && [[ -z "$oneline" ]] && https $verbiage $GITLAB_URL/api/v4/projects \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN | jq $jqQuery

  }

function _ggpo_scrape_page() {
  # get from url in $1
  # download results to $2
  # save header response to $3
  # _ggpo_scrape_page url result.json header
  echo $fg[yellow] Downloading$reset_color $1 to $fg[green]$2$reset_color
  # https -dh $1 PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN per_page==100 >$2 2>$3
  https -dh $1 PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN per_page==100 >$2 2>$3
}

function _ggpo_next_link_from_header() {
  # rg - get the next link, not the prev or last etc link
  # use tr to split the link at < and >
  # sample link: Link: <https://git.ads.certis.site/api/v4/projects?membership=false&order_by=created_at&owned=false&page=2&per_page=100&simple=false&sort=desc&starred=false&statistics=false&with_custom_attributes=false&with_issues_enabled=false&with_merge_requests_enabled=false>; rel="next",
  cat $1 | tr '<,' '\n' | rg next | tr '>' '\n' | head -n 1
}

function _ggpo(){
  # paginate and get all projects
  # use the next link header to get the next page
  # use jq to combine all the intermediate json results into 1 json
  # _ggpo

  local outdir=$(mktemp -d /tmp/gitlab.projects.XXX)
  local page=1
  local nextUrl=https://git.ads.certis.site/api/v4/projects

  while [ ! -z "${nextUrl}" ]; do
    _ggpo_scrape_page $nextUrl $outdir/page${page}.json $outdir/header
    nextUrl=$(_ggpo_next_link_from_header $outdir/header)
    page=$(( $page + 1 ))
  done

  # https://stackoverflow.com/questions/55995980/why-does-inputs-skip-the-first-line-of-the-input-file 
  # jq - -n == --null-input
  # inputs takes each json file and outputs them all
  # null input works with inputs
  # if you do jq '[.[]]', it won't work
  # assuming each json file is a row with an array
  # the above simply unwraps the array and then adds the array again
  #
  # you want to pass every row, unwrap each row, then wrap everything
  # [inputs | .[]]
  # inputs will eat the first row and output all the ramaining rows by default
  # so pass null input so that inputs will pass all the rows
  local allProjects=$(jq --null-input '[inputs| .[]]' $outdir/*.json)
  # local allProjects=$(jq '[.[]]' $outdir/*.json)
  # jq -r 'tostring' <<< $allProjects
  local jqQuery='.[] | (.id|tostring) + " " + .name + " " + .created_at'

  # -V - version sort, so that 1,2 ..., 11 are sorted correctly
  jq --raw-output $jqQuery <<< $allProjects | sort -V | column -t
}
