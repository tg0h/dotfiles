# https://en.wikipedia.org/wiki/Control_character#In_ASCII
# the terminal interprets certain key codes by default - eg ^M is the carriage return

bindkey -r "^G" # remove ctrl g so that junegunn's fzf_git functions work
# bindkey -r "^N"
bindkey -r "^K"
bindkey -r "^H"
bindkey -r "^S"

# file searchers
zle     -N   fzf-search-dotfiles-widget
# bindkey '^N^H' fzf-search-dotfiles-widget
zle     -N   fzf-search-wiki-widget
# bindkey '^N^W' fzf-search-wiki-widget
zle     -N   fzf-search-bookmarks-widget
# bindkey '^N^M' fzf-search-bookmarks-widget
zle -N _fzf-redraw-prompt # used by fzf bookmarks widget to redraw prompt

# npm
zle -N fzf-search-package-widget
bindkey '^s^g' fzf-search-package-widget
zle -N fzf-search-package-downwards-widget
bindkey '^s^f' fzf-search-package-downwards-widget

zle -N fzf-search-filenameAndContent-widget
bindkey '^h' fzf-search-filenameAndContent-widget


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
