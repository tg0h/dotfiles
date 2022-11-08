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

# TODO: understand piping wizadry needed to open terminal nvim with ctrl e keybind
# https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983

# --color='hl:-1:underline,hl+:-1:underline:reverse'
# hl - colour of matching substrings. -1 means accept the original colour
# hl+ - colour of matching substrings on current line

export FZF_X_NVIM="execute(echo {} > /tmp/_nvim_cache && nvim {} > /dev/tty 2>&1)"
# --info=inline
export FZF_DEFAULT_OPTS="
--ansi
--no-mouse
--height 80%
--reverse
--multi
--cycle
--color='gutter:-1,hl:-1:underline:#03ff13,hl+:-1:underline:reverse'

--header-first
--header=$'⌃H ⌃S ⌃A ⌃Y ⌃E ⌃␣ ⌥C ⇧⌥C F2' \

--bind='f2:toggle-preview'
--bind='ctrl-d:half-page-down'
--bind='ctrl-u:half-page-up'

--bind 'ctrl-h:preview-half-page-up'
--bind 'ctrl-s:preview-half-page-down'

--bind='ctrl-a:select-all+accept'
--bind='ctrl-y:execute-silent(echo {+} | join-lines-fzf | pbcopy)+abort'
--bind 'ctrl-e:$FZF_X_NVIM+abort'
--bind 'ctrl-/:change-preview-window(right,80%|down,90%,border-top|hidden|)'
--bind='alt-c:execute(rm {})+abort'
--bind='alt-C:execute(trash {})+abort'

--bind backward-eof:abort
--bind 'ctrl-space:jump'
"

FD_OPTIONS="--color always --follow --hidden"

FD_OPTIONS_NO_IGNORE="$FD_OPTIONS \
--no-ignore \
--exclude .git \
--exclude node_modules \
--exclude .DS_Store \
--exclude build \
--exclude cdk.out
"
export FZF_DEFAULT_COMMAND="fd . --type f --hidden --follow --exclude .git $FD_OPTIONS"

# include git ignore since there shouldn't be too many such directories
export FD_C_OPTIONS="$FD_OPTIONS --type d"
export FD_C_OPTIONS_NO_IGNORE="$FD_OPTIONS_NO_IGNORE --type d"
export FZF_ALT_C_COMMAND="fd $FD_C_OPTIONS"
export FZF_ALT_C_OPTS="
--preview 'lsd {} --tree --color always --icon always'
--preview-window='right:wrap,noborder'
--header=$'⌥r ⌥g ⌥l ⌥c ⌥f' \
--bind 'alt-r:reload(exa --oneline --color always --sort accessed --reverse --only-dirs)+change-prompt(depth:1> )'
--bind 'alt-g:reload(fd $FD_C_OPTIONS --max-depth 2 )+change-prompt(depth:2> )'
--bind 'alt-l:reload(fd $FD_C_OPTIONS --max-depth 3 )+change-prompt(depth:3> )'
--bind 'alt-c:reload(fd $FD_C_OPTIONS )+change-prompt(> )'
--bind 'alt-f:reload(fd $FD_C_OPTIONS_NO_IGNORE )+change-prompt(no-ignore> )'
--bind 'alt-d:reload(fd package.json | xargs dirname)+change-prompt(package.json> )'
--bind 'space:down'
--bind 'tab:up'
"

export FZF_COMPLETION_TRIGGER='##'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# below functions work with the completion trigger
# uses fd instead of find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
