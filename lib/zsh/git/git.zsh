function gtd (){
  # delete local tags with git tag -d <tagName>
  # gtd <tagName>
  git tag -d $1
}

function gtdd (){
  # delete remote tags with git push --delete origin
  # gtdd <tagName>
  # this uses the same base git command that gbrmd etc uses
  # git tag -l | rg '^v' | xargs -I {} git push --delete --dry-run origin {}
  
  git push --delete origin $1
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
function gbca (){
  # accept a single branch or a space delimited branch
  # gbca <branch1>
  # gbca <branch1> <branch2>
  # branch example: origin/sprint-21/feature/ARG-2723/develop

  for branch in "$@"
  do
    echo checking $fg[yellow]$branch
    git branch -a --contains $branch
  done

}

# alias gpdo="git push -d origin" #delete a remote branch
function gpdo(){
  # gpdo expects origin/featureBranch to be passed
  # gpdo will cut away the first field and delete the "featureBranch" branch

  # pass first parameter to stdin of gcut command
  local branch=$(gcut -f2- -d/ <<< "$1")
  git push -d origin $branch
}

function gbdd(){
  # delete local git branches with a search string
  #EXAMPLES:
  # gbdd <search string>
  # gbdd -d <search string> - force delete

  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbdd sprint-13
  #might need to run git fetch --prune to clean up remote before running this command

  local force=""
  while getopts 'd' opt; do
    case "$opt" in
      d) force=true;;
    esac
  done
  shift $(($OPTIND - 1))


  # if [[ -z $1 ]]; then
  #   echo please provide a search string, eg gbmrd sprint-18
  #   exit
  # fi
  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  # xargs
  #   -P - number of processes to run
  #   -n - how many arguments from stdin to pass to each xargs command
  if [[ -n $force ]]; then
    gb | rg '^\s*'$1 | xargs -P 12 -n 1 -I{} git branch -D {}
  else;
    gb | rg '^\s*'$1 | xargs -P 12 -n 1 -I{} git branch -d {}
  fi
}

#TODO: refactor gbmrd and gbnmrd, dd
function gbnmrd(){
  #dry run delete git remote branches with a search string
  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbmrd -n sprint-18 - dry run delete with search term
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command
  local dryRun=""
  while getopts 'n' opt; do
    case "$opt" in
      n) dryRun="--dry-run";;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -z $1 ]]; then
    echo please provide a search string, eg gbnmrd sprint-18
    return
  fi
  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  # xargs
  #   -P - number of processes to run
  #   -n - how many arguments from stdin to pass to each xargs command

  #if dryRun, print dry run
  [[ -n $dryRun ]] && echo dry run:
  git branch -r --no-merged | rg -v 'release' | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push $dryRun -d origin {}
  # gbnmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push --dry-run -d origin {}
}

function gbmrd(){
  #dry run delete git remote branches with a search string
  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbmrd -n sprint-18 - dry run delete with search term sprint-18
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command
  local dryRun=""
  while getopts 'n' opt; do
    case "$opt" in
      n) dryRun="--dry-run";;
    esac
  done
  shift $(($OPTIND - 1))


  if [[ -z $1 ]]; then
    echo please provide a search string, eg gbmrd sprint-18
    exit
  fi
  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  # xargs
  #   -P - number of processes to run
  #   -n - how many arguments from stdin to pass to each xargs command
  # gbmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push --dry-run -d origin {}

  #if dryRun, print dry run
  [[ -n $dryRun ]] && echo dry run:
  git branch -r --merged | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push $dryRun -d origin {}
}

# =============================================================================

