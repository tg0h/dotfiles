alias g="git -P" # turn off pager to disable delta

# status
alias a='git status -s'
alias a,='git commit -m'
alias ao='git add'
alias ao.='git add .'
alias aoe='git commit --amend --no-edit'
alias aoeu='gg' # quickly add and commit

# undo
alias aus="git reset --soft @~"
alias auh="git reset --hard @~"
alias aut="git reset --mixed @~"

# diff
alias o="git diff"
alias oo="git -P diff" # don't use delta (specify no pager)
alias oe="git diff --cached"

alias i="git fuzzy status"

# log
alias e="glo"
# alias e.="glo | fzf"
alias eu="git reflog"
# alias ue="git status --short"

# rebase
alias ue="git commit --fixup :/"
alias u="git rebase --interactive --autosquash"
alias uo="git reset --soft @~"

alias gyy="git fuzzy"
alias gy="git fuzzy log"
alias gy,="git fuzzy branch"
alias gy.="git fuzzy diff"
alias gy,.="git fuzzy reflog"
# alias u="git fuzzy status"
alias gya="git fuzzy stash"

alias q="lazygit"
# the zsh git plugin defines git aliases in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
# unalias gg # remove alias set by omz git plugin
alias g.="gloz -10 --color=always D"
alias g..="gloz -20 --color=always D"
alias g,.="glodm --color=always D"
alias g,.p="glodmm --color=always D"

alias ggp="gg && gp"
alias gge="gg -e" # allow empty commit
alias ggc="gg -c" # specify a checkpoint message
alias gga="git add --all && gcan!" # add and amend previous commit

alias gao="git commit --amend --no-edit" # add staged files to previous commit
alias gaoe="git add --all && git commit --amend --no-edit" # stage and add files to previous commit

alias ge="git clone"

alias grpi="git rev-parse --is-inside-work-tree"
alias grpa="git rev-parse --absolute-git-dir"
alias grpt="git rev-parse --show-toplevel"
alias grpb="git rev-parse --is-bare-repository"

# review
alias gr.='gr @~' # review with previous commit
alias gr,='gr master' # review comparing to master

# diff
alias ad='gd'
alias gdst='git diff --stat'
alias gdms='git diff main --stat'

# diff-filter=d
# https://git-scm.com/docs/git-diff
alias gdnm="git diff --name-only main..." # git merge base with main, add --diff-filter=... option to filter
alias gdnsm='git diff --name-status main..'

alias gdnmm="git diff --name-only" # git merge base with main
alias gdns='git diff --name-status main..'
alias gdnss='git diff --name-status'

alias gdcn='git diff --cached --name-only'
alias gdn="git diff --name-only"
alias gdc="git diff --cached"

# status
alias g,="git status --short"

# commit
alias gcn="gc -n"

# worktree
alias gwl="git worktree list"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gwp="git worktree prune"

# fetch - worktrees
alias gfos="git fetch origin '+*:*' --prune" # from a bare repo, get everything

# branch status
alias gbv="git branch -v"
alias gbvv="git branch -vv"

# config
alias gcl="git config --list"
alias gcls="git config --list --show-origin"

# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbm="git branch --merged"
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbmr="git branch -r --merged"
# alias gbnm="git branch --no-merged" - defined in git plugin
# if you don't specify a branch, it compares against the current HEAD you're on, ie which branch you're currently on
alias gbnmr="git branch -r --no-merged | rg -v 'release'"

alias glv="git log --graph --raw --stat --numstat --compact-summary --dirstat --summary --parents --abbrev-commit --format=fuller"
alias gloz="git log --graph --date=format:'%I:%M %p' --pretty='%>|(10,trunc)%Cred%h%Creset %C(bold blue)%cs %Cgreen%ad%Creset %<(50,trunc)%s %<(6,trunc)%C(yellow)%ar %<(8,trunc)%C(cyan)%an%Creset%<(20,trunc)%C(auto)%d'"
alias glozm="gloz -10"
alias glod="git log --date=human --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset %C(yellow)%ar%Creset'"
alias glodm='glod -10'
alias glodmm='glod -20'

alias gin="git init"

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
# alias gwt='git write-tree'
alias grt='git read-tree'
alias gsr='git symbolic-ref'
alias gct='git commit-tree'

alias gmb="git merge-base"
# alias gcmm='git add . && git commit -m '
alias gbc='git branch --contains'
#check remote branches as well
# promote gbca to a function
# alias gbca='git branch -a --contains'

alias gs='git show'
alias gsp='git status --porcelain'
alias gsno='git show --name-only'
