alias lg="lazygit"
# the zsh git plugin defines git aliases in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
function gg(){
  #lazy git commiting when prototyping
  git add .
  if [ -z "$1" ]; then
    git commit -m 'gg'
  else
    git commit -m "$1"
  fi
}

# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbm="git branch --merged"
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbmr="git branch -r --merged"
# alias gbnm="git branch --no-merged" - defined in git plugin
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbnmr="git branch -r --no-merged | rg -v 'release'"

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
# promote gbca to a function
# alias gbca='git branch -a --contains'

# GIT Aliases
alias g='git'
alias gst='git status'
alias gd='git diff'
alias ge='git describe'
alias gf='git fetch'
alias gdns='git diff --name-status'
alias gdc='git diff --cached'
alias gdcn='git diff --cached --name-only'
alias gl='git pull'
alias gup='git pull --rebase'
alias gpro='git pull --rebase origin'
alias gp='git push'
alias gpo='git push origin'
alias gc='git commit -v'
alias gcf='git commit --fixup'
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
alias grbia='git rebase -i --autosquash'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gbav='git branch -a -v'
alias gcl='git config --list'
alias gcls='git config --list --show-origin'
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
alias glps='git log --patch -S'

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

# alias gg='git gui citool'
# alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstac='git stash clear'
alias gstal='git stash list'
alias gstp='git stash pop'
# gstu <path to file>
alias gstu='git stash push' 
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
alias gpsup='git push --set-upstream origin $(current_branch)'

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
