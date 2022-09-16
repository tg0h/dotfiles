# https://en.wikipedia.org/wiki/Control_character#In_ASCII
# the terminal interprets certain key codes by default - eg ^M is the carriage return

bindkey -r "^G" # remove ctrl g so that junegunn's fzf_git functions work
# bindkey -r "^N"
# bindkey -r "^K"
# bindkey -r "^H"
# bindkey -r "^S"
# bindkey -r "^[S"

# unbind Meh-_ from copy-prev-word and map to copy-prev-shell-word instead
bindkey '^[^_' copy-prev-shell-word
bindkey '^[^h' run-help
bindkey '^[^r' redo

# alt-ctrl-t to transpose words
bindkey '^[^t' transpose-words

# replace current region with contents of kill buffer
bindkey '^[v' put-replace-selection
# https://unix.stackexchange.com/questions/51933/zsh-copy-and-paste-like-emacs
# alt-w
zle -N pb-copy-region-as-kill
bindkey -e '\ew' pb-copy-region-as-kill
zle -N pb-backward-kill-line
bindkey -e '^u' pb-backward-kill-line
zle -N pb-kill-line
bindkey -e '^k' pb-kill-line

# file searchers
zle     -N   fzf-search-dotfiles-widget
# bindkey '^N^H' fzf-search-dotfiles-widget
zle     -N   fzf-search-wiki-widget
# bindkey '^N^W' fzf-search-wiki-widget
zle     -N   fzf-search-bookmarks-widget
# bindkey '^N^M' fzf-search-bookmarks-widget
zle -N _fzf-redraw-prompt # used by fzf bookmarks widget to redraw prompt

zle -N fzf-docker-container-widget
# replaces the quoted-insert widget
bindkey '^V' fzf-docker-container-widget
zle -N fzf-docker-image-widget
bindkey '^[^V' fzf-docker-image-widget

# npm
# zle -N fzf-search-package-widget
# bindkey '^s^g' fzf-search-package-widget
# zle -N fzf-search-package-downwards-widget
# bindkey '^s^f' fzf-search-package-downwards-widget

zle -N fzf-search-filenameAndContent-widget
bindkey '^[-' fzf-search-filenameAndContent-widget

zle -N fzf-search-cloudwatch-logs-widget
bindkey '^[^r' fzf-search-cloudwatch-logs-widget

# fzf git widgets
zle -N fzf-gh-widget # commits
bindkey '^g^h' fzf-gh-widget
zle -N fzf-gb-widget # branches
bindkey '^g^b' fzf-gb-widget
zle -N fzf-gt-widget # tags
bindkey '^g^t' fzf-gt-widget
zle -N fzf-gf-widget # files
bindkey '^g^f' fzf-gf-widget
zle -N fzf-gr-widget # remotes
bindkey '^g^r' fzf-gr-widget
zle -N fzf-gs-widget # stashes
bindkey '^g^s' fzf-gs-widget

zle -N fzf-brancher-widget # general purpose branch switcher/deleter
bindkey '^l' fzf-brancher-widget

# Alt+Backspace to backward kill to dir segment
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# C-S--
bindkey '^_' copy-prev-shell-word
