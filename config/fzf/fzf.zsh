# # Setup fzf
# # ---------
# if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
# fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------

# source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# m1 mini homebrew location
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

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

# --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
# --preview='[[ \$(file --mime {}) =~ inode/directory ]] && fd . {} --hidden --color always --max-depth 2 || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'

# --preview='[[ \$(file --mime {}) =~ inode/directory ]] && exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse {} || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
# --preview-window hidden

# --color='hl:-1:underline,hl+:-1:underline:reverse'
# hl - colour of matching substrings. -1 means accept the original colour
# hl+ - colour of matching substrings on current line
# --bind='ctrl-d:half-page-down'
# -1

# --bind 'ctrl-c:preview-down'
# --bind 'ctrl-r:preview-up'
export FZF_DEFAULT_OPTS="
--ansi
--no-mouse
--height 80%
--info=inline
--reverse
--multi
--cycle
--color='gutter:-1,hl:-1:underline:#03ff13,hl+:-1:underline:reverse'
--bind='f3:execute(bat --style=numbers {} || less -f {})'
--bind='f2:toggle-preview'
--bind='ctrl-d:half-page-down'
--bind='ctrl-u:half-page-up'

--bind 'ctrl-h:preview-half-page-down'
--bind 'ctrl-t:preview-half-page-up'

--bind='ctrl-a:select-all+accept'
--bind='ctrl-y:execute-silent(echo {+} | join-lines-fzf | pbcopy)+abort'
--bind 'ctrl-e:execute(echo {} > /tmp/_nvim_cache && nvim {} > /dev/tty 2>&1)+abort'
--bind 'ctrl-/:change-preview-window(right,80%|down,90%,border-top|hidden|)'
--bind='alt-c:execute(rm {})+abort'
--bind='alt-C:execute(trash {})+abort'

--bind backward-eof:abort
--bind 'ctrl-/:jump'
"

# --bind='ctrl-r:execute(echo {} > /tmp/_so_cache)+abort'

# NOTE: trash is slower than rm -rf but is safer
# the _nvim_cache should only contain 1 file

# --bind 'ctrl-s:toggle-sort'

#--preview-window='right:hidden:wrap'

FD_OPTIONS="--color always --follow --hidden --no-ignore --exclude .git \
--exclude node_modules \
--exclude .DS_Store \
"
export FZF_DEFAULT_COMMAND="fd . --type f --hidden --follow --exclude .git $FD_OPTIONS"
# export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPIONS"
# --hidden -include hidden files
# --follow -include symbolic links
# --no-ignore-vcs - include vcs files
#export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'

#search to exclude .git and node_modules
alias fzfi='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}" | fzf'

export FZF_CTRL_R_OPTS="--preview-window='right:hidden:wrap'"

export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="
--preview='[[ \$(file --mime {}) =~ inode/directory ]] && exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse {} || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
--preview-window='right:wrap'
--bind 'ctrl-r:reload(fd . --type f --follow --color always )+change-prompt(file>)'
--bind 'ctrl-l:reload(fd . --type d --follow --color always )+change-prompt(dir>)'
--bind 'ctrl-g:reload(fd . --follow --color always )+change-prompt(>)'
--bind 'ctrl-space:execute(echo {} > /tmp/_nvim_cache && nvim {} > /dev/tty 2>&1)+abort'
"
#The following example uses tree command to show the entries of the directory.
#show directories, include hidden dirs, include ignored files/folders from .gitignore
export FZF_ALT_C_COMMAND="fd --type d --hidden --no-ignore $FD_OPTIONS"
export FZF_ALT_C_OPTS="
--preview 'lsd {} --tree --color always --icon always'
--bind 'alt-r:reload(fd --type d --max-depth 1 --hidden --no-ignore $FD_OPTIONS)+change-prompt(depth:1>)'
--bind 'alt-c:reload(fd --type d --hidden --no-ignore $FD_OPTIONS)+change-prompt(>)'
--bind 'space:down'
--bind 'tab:up'
"

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
