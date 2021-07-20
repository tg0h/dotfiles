# NOTE the key bindings, ctrl e, ctrl v etc
# to get mvim on the command line, brew install macvim

# show fzf options top down instead of bottom up
# use height of 40%
# use highlight to preview file with colour
# export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
# turn off preview window by adding right:hidden:wrap
#
# TODO: understand piping wizadry needed to open terminal nvim with ctrl e keybind
# https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983

export FZF_DEFAULT_OPTS="
--no-mouse
--height 50%
-1
--reverse 
--multi 
--inline-info 
--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' 
--bind='f3:execute(bat --style=numbers {} || less -f {})'
--bind='f2:toggle-preview'
--bind='ctrl-d:half-page-down'
--bind='ctrl-u:half-page-up'
--bind 'shift-up:preview-half-page-up'
--bind 'shift-down:preview-half-page-down'
--bind='ctrl-a:select-all+accept'
--bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty 2>&1)'
"
# --bind 'ctrl-s:toggle-sort'

#--preview-window='right:hidden:wrap' 

#export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPIONS"
# --hidden -include hidden files
# --follow -include symbolic links
# --no-ignore-vcs - include vcs files
#export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules"

#search to exclude .git and node_modules
alias fzfi='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}" | fzf'

export FZF_CTRL_R_OPTS="--preview-window='right:hidden:wrap'"

export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview-window='right:wrap'"

#The following example uses tree command to show the entries of the directory.
#show directories, include hidden dirs, include ignored files/folders from .gitignore
export FZF_ALT_C_COMMAND="fd --type d --hidden --no-ignore $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"



#use ~~ instead of **
export FZF_COMPLETION_TRIGGER='##'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}



# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# FILE SEARCH
# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

#access chrome bookmarks from shell
b() {
  local bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks
  local jq_script='def ancestors: while(. | length >= 2; del(.[-1,-2])); . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'
  jq -r $jq_script < "$bookmarks_path" \
  | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
  | fzf --ansi \
  | cut -d$'\t' -f2 \
  | xargs open
}

#brew management
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}
# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
install() {
    local token
    token=$(brew search --casks | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew cask install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew cask home $token
        fi
    fi
}
# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
uninstall() {
    local token
    token=$(brew cask list | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepage of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew cask uninstall $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew cask home $token
        fi
    fi
}

## DOCKER
# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# Directly execute the command in shell with ctrl x ctrl r
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

fzf-search-wiki-widget() {
  fd --color always . '/Users/tim/certis/resources/wiki' | fzf --ansi
}
zle     -N   fzf-search-wiki-widget  
bindkey '^S' fzf-search-wiki-widget

fzf-search-dotfiles-widget() {

  #include f - files and l - symlinks
  local FD_FILETYPE="--type f --type l"
  # --follow - follow symlinks
  # --hidden - include hidden files and directories
  local FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules"

  #do not show hidden files, since my files in dotfiles will not be hidden
  fd . \
      --color always \
      --type f --type l \
      --follow \
      --exclude .git \
      --exclude node_modules \
      --exclude dotbot '/Users/tim/dotfiles' | fzf --ansi
}

zle     -N   fzf-search-dotfiles-widget  
bindkey '^N' fzf-search-dotfiles-widget
