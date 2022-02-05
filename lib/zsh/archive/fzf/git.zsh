# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# zsh keymap docs: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
# https://junegunn.kr/2016/07/fzf-git/

# GIT heart FZF
# -------------

# compare lazy load vs eval?

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 100% "$@" --border
}

# search for files
_gf() {
  #if not in git repo, return
  is_in_git_repo || return
  git -c color.status=always status --short |
    fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
    cut -c4- | sed 's/.* -> //'
  }

# search for branches
_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    # use <<< to pass a string to sed
    fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(green bold)%cd %C(auto)%h%d %s %C(magenta)(%an)%Creset %C(cyan)%ar%Creset" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
  }

# search for tags
_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
    fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
  }

# search for commits
_gh() {
  is_in_git_repo || return
  # git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s %C(magenta)(%an)%Creset %C(cyan)%ar%Creset" --graph --color=always |
    fzf-down --ansi --no-sort --reverse --multi \
    --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
    grep -o "[a-f0-9]\{7,\}"
  }

# search for remotes
_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
    cut -d$'\t' -f1
  }

# search for stashes
_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
    cut -d: -f1
  }

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

#NOTE: ctrl g is already bound by the 'main' keymap in zsh
#to see the bound keys, run this command in zsh: bindkey "^G"
#to see the zsh keymaps run bindkey -l
#to see the currently bound keys for the current keymap, run bindkey
bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h s
unset -f bind-git-helper
