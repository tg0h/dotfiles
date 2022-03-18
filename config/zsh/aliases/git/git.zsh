alias lg="lazygit"
# the zsh git plugin defines git aliases in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
# unalias gg # remove alias set by omz git plugin
function gg(){
  #lazy git commiting when prototyping
  local message="$@"
  git add .
  if [ -z "$message" ]; then
    # just get the filename from the first line and use that as the commit message
    # copy from the 4th char onwards
    message=$(git status --porcelain | head -n 1  | cut -c 4-)
  fi
  git commit -m "$message"
}

alias g.="gloz -10"
alias g,.="glodm"

# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbm="git branch --merged"
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbmr="git branch -r --merged"
# alias gbnm="git branch --no-merged" - defined in git plugin
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbnmr="git branch -r --no-merged | rg -v 'release'"

alias gloz="git log --graph --date=format:'%I:%M %p' --pretty='%>|(10,trunc)%Cred%h%Creset %C(bold blue)%cs %Cgreen%ad%Creset %<(50,trunc)%s %<(6,trunc)%C(yellow)%ar %<(8,trunc)%C(cyan)%an%Creset%<(40,trunc)%C(auto)%d'"
alias glozm="gloz -10"
alias glod="git log --date=human --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset %C(yellow)%ar%Creset'"
alias glodm='glod -10'
alias glodmm='glod -20'

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

alias gs='git show'
alias gsp='git status --porcelain'
alias gsno='git show --name-only'
