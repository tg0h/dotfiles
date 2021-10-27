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

