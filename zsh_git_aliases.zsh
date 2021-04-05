# the zsh git plugin defines git aliases in ~/.oh-my-zsh/plugins/git/git.plugin.zsh

# my git favourites
# alias gpdo="git push -d origin" #delete a remote branch
function gpdo(){
  # gpdo expects origin/featureBranch to be passed
  # gpdo will cut away the first field and delete the "featureBranch" branch
  
  # pass first parameter to stdin of gcut command
  local branch=$(gcut -f2- -d/ <<< "$1")
  git push -d origin $branch
}


# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbm="git branch --merged"

# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbmr="git branch -r --merged"

# alias gbnm="git branch --no-merged" - defined in git plugin
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbnmr="git branch -r --no-merged"

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
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command

  if [[ -z $1 ]]; then
    echo please provide a search string, eg gbnmrd sprint-18
    exit
  fi
  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  # xargs
  #   -P - number of processes to run
  #   -n - how many arguments from stdin to pass to each xargs command
  gbnmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push --dry-run -d origin {}
}

#TODO: refactor gbmrd and gbnmrd, dd
function gbnmrdd(){
  #dry run delete git remote branches with a search string
  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command

  if [[ -z $1 ]]; then
    echo please provide a search string, eg gbnmrd sprint-18
    exit
  fi
  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  # xargs
  #   -P - number of processes to run
  #   -n - how many arguments from stdin to pass to each xargs command
  gbnmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push -d origin {}
}

function gbmrd(){
  #dry run delete git remote branches with a search string
  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command

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
  gbmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push --dry-run -d origin {}
}

function gbmrdd(){
  #dry run delete git remote branches with a search string
  #NOTE: git branch -r --merged is with reference to the branch you are currently on!
  #example: gbmrd sprint-18
  #might need to run git fetch --prune to clean up remote before running this command

  # cut
  #   f2- - cut from the second field to the end of line
  #   -d/ - use a field separator of /
  gbmr | rg $1 | gcut -f2- -d/| xargs -P 12 -n 1 -I{} git push -d origin {}
}


# =============================================================================

# REVIEW functions ============================================================
REVIEW_BASE=master
gfiles(){
  git diff --name-only $(git merge-base HEAD $REVIEW_BASE)
}

gstats(){
  git diff --stat $(git merge-base HEAD $REVIEW_BASE)
}

greview(){
  #-p - open files in tabs in vim
  #+ run the command in vim
  vim -p $(gfiles) +"tabdo Gdiff $REVIEW_BASE" +"let g:gitgutter_diff_base = '$REVIEW_BASE'"
}

greviewone(){
  vim -p +"tabdo Gdiff $REVIEW_BASE" +"let g:gitgutter_diff_base = '$REVIEW_BASE'"
}
# REVIEW functions ============================================================

# GIT PLUMBING
alias gcf="git cat-file"
alias gcfp="git cat-file -p"
alias gcfpht="git cat-file -p head^{tree}"
alias gcft="git cat-file -t"
alias glf='git ls-files'
alias glfs='git ls-files -s'
alias gho='git hash-object'
alias ghow='git hash-object -w'
alias gcf='git cat-file'
alias gui='git update-index'
alias guia='git update-index --add'
alias guiac='git update-index --add --cacheinfo'
alias gur='git update-ref'
alias gwt='git write-tree'
alias grt='git read-tree'
alias gsr='git symbolic-ref'
alias gct='git commit-tree'

alias gmb="git merge-base"
alias gcmm='git add . && git commit -m'
alias gbc='git branch --contains'
#check remote branches as well
alias gbca='git branch -a --contains'

# GIT Aliases
alias g='git'
alias gst='git status'
alias gd='git diff'
alias gf='git fetch'
alias gdns='git diff --name-status'
alias gdc='git diff --cached'
alias gdcn='git diff --cached --name-only'
alias gl='git pull'
alias gup='git pull --rebase'
alias gp='git push'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gcl='git config --list'
alias gcp='git cherry-pick'

alias gcount='git shortlog -sn'
alias gsl='git shortlog'
# alias gl="git log --all --decorate --graph"
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all --left-right'
alias glo='git log --oneline --decorate --color --left-right'
alias glod="git log --date=human --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset %C(yellow)%ar%Creset'"
alias glodm='glod -10'
alias glodmm='glod -20'
alias glog='git log --oneline --decorate --color --graph --left-right'
# alias glog1="git log --all --decorate --graph --since=1.weeks"
# alias glog2="git log --all --decorate --graph --since=2.weeks"
alias glogm='git log --oneline --decorate --color --graph --max-count=10'

alias gss='git status -s'
alias ga='git add'
alias gai='git add -i'

#MERGE
alias gm='git merge'
alias gmf='git merge --no-ff'

#dfx - remove untracked (directories, files and ignored)
alias gclean='git reset --hard && git clean -dfx'

#RESET
alias gr='git reset'
alias grh='git reset --hard'
# alias grhh='git reset HEAD --hard'

alias gs='git show'

alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

#remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all && git push origin --tags'
alias gmt='git mergetool --no-prompt'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstac='git stash clear'
alias gstal='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
# alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gsr='git svn rebase'
alias gsd='git svn dcommit'

# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

# functions
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
      echo ${ref#refs/heads/}
    }

  function current_repository() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(git rev-parse --short HEAD 2> /dev/null) || return
          echo $(git remote -v | cut -d':' -f 2)
        }

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}
