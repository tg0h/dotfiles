# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# TODO: understand piping wizadry needed to open terminal nvim with ctrl e keybind
# https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983

# --color='hl:-1:underline,hl+:-1:underline:reverse'
# hl - colour of matching substrings. -1 means accept the original colour
# hl+ - colour of matching substrings on current line

# --scrollbar '▌▐'
export FZF_X_NVIM="execute(echo {} > /tmp/_nvim_cache && nvim {} > /dev/tty 2>&1)"
# --info=inline
export FZF_DEFAULT_OPTS="
--ansi
--no-mouse
--height 80%
--reverse
--multi
--cycle
--color='gutter:-1,hl:-1:underline:#03ff13,hl+:-1:underline:reverse,scrollbar:grey,preview-scrollbar:grey'
--separator=''
--scrollbar='▏▏'

--header-first
--header=$'⌃H ⌃S ⌃A ⌃Y ⌃E ⌃␣ ⌥C ⇧⌥C F2' \

--bind='ctrl-space:toggle-preview'
--bind='ctrl-z:toggle-preview'

--bind='ctrl-d:half-page-down'
--bind='ctrl-u:half-page-up'

--bind 'ctrl-^:preview-half-page-up'
--bind 'ctrl-h:preview-half-page-up'
--bind 'ctrl-s:preview-half-page-down'

--bind='ctrl-a:up'
--bind='ctrl-y:execute-silent(echo {+} | join-lines-fzf | pbcopy)+abort'
--bind 'ctrl-e:$FZF_X_NVIM'
--bind 'ctrl-alt-e:$FZF_X_NVIM+abort'
--bind 'ctrl-/:change-preview-window(right,80%|down,90%,border-top|hidden|)'
--bind='alt-c:execute(trash {})'
--bind='alt-C:execute(rm {})'

--bind backward-eof:abort
"
# --bind 'ctrl-space:jump'
# --bind='ctrl-a:select-all+accept'

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
