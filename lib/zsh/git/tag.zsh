function gtp(){
  # push tags
  # By default, git push will not push tags.
  # Tags have to be explicitly passed to git push.
  # To push multiple tags simultaneously pass the --tags option to git push
  # command.
  
  git push --tags
}

function gtr(){
  # prune tags
  # delete local tags that don't belong in remote
  # https://git-scm.com/docs/git-fetch
  git fetch origin --prune --prune-tags
}

function gtd (){
  # delete local tags with git tag -d <tagName>
  # gtd <tagName>
  git tag -d $1
}

function gtdd (){
  # delete remote tags with git push --delete origin
  # accepts a wildcard that must match exactly the start of the tag
  # eg gtdd v1 deletes all tags that begin with v1
  # gtdd <tagName|wildcard>
  # gtdd -n <tagName|wildcard> dry run delete

  local dryRun
  while getopts 'n' opt; do
    case "$opt" in
      n) dryRun="--dry-run"
      echo $fg[yellow]dry run delete '...' $reset_color
        ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -z "$1" ]]; then
    echo $fg[red]err:$reset_color please provide a search string 
    return 1
  fi 

  # TODO: depends on gtl alias defined in zsh git plugin?
  gtl $1 | choose 0 | xargs -I{} git push --delete $dryRun origin {} 
}

function gtaf(){
  # overwrite a tag
  # gtaf <tagName> <tag annotation>
  
  git tag -f -a $1 -m $2
}
function gta (){
  # add an annotated git tag with git tag -a
  # optionally support a message with -m
  # gta <tagName>
  # gta <tagName> <tag annotation>
  git tag -a $1 -m $2
}

function gtlr(){
  # show remote tags
  # note that git ls-remote --tags origin has messier output
  
  git show-ref --tags
}
