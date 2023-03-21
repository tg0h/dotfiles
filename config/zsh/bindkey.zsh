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
# bindkey '^[^t' transpose-words

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
zle -N pb-backward-kill-word
bindkey -e '^w' pb-backward-kill-word

# file searchers
zle     -N   fzf-search-dotfiles-widget
# bindkey '^N^H' fzf-search-dotfiles-widget
zle     -N   fzf-search-wiki-widget
bindkey '^[^W' fzf-search-wiki-widget
zle     -N   fzf-search-bookmarks-widget
# bindkey '^N^M' fzf-search-bookmarks-widget
zle -N _fzf-redraw-prompt # used by fzf bookmarks widget to redraw prompt

zle -N fzf-docker-container-widget
# replaces the quoted-insert widget
bindkey '^V' fzf-docker-container-widget
zle -N fzf-docker-image-widget
bindkey '^[^V' fzf-docker-image-widget

# npm
zle -N fzf-search-package-widget
bindkey '^[^s' fzf-search-package-widget
zle -N fzf-search-package-downwards-widget
bindkey '^[^n' fzf-search-package-downwards-widget
zle -N fzf-search-package-json-widget
bindkey '^[g' fzf-search-package-json-widget

# ts
zle -N fzf-search-ts-config-widget
bindkey '^[j' fzf-search-ts-config-widget

zle -N fzf-search-filenameAndContent-widget
bindkey '^[-' fzf-search-filenameAndContent-widget

zle -N fzf-search-cloudwatch-logs-widget
bindkey '^[^f' fzf-search-cloudwatch-logs-widget
zle -N dropdowner
bindkey '^[^r' dropdowner
zle -N fzf-search-sqs-queues-widget
# bindkey '^[^l' fzf-search-sqs-queues-widget

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
bindkey '^b' fzf-brancher-widget
zle -N fzf-logger-widget # git logger widget
bindkey '^l' fzf-logger-widget
zle -N fzf-status-widget
bindkey '^s' fzf-status-widget
zle -N fzf-differ-widget # git logger widget
bindkey '^[r' fzf-differ-widget
zle -N fzf-git-repo-widget 
bindkey '^[^l' fzf-git-repo-widget

zle -N fzf-code-pipeline-widget # show action executions for a code pipeline
bindkey '^[^g' fzf-code-pipeline-widget
zle -N fzf-s3-bucket-widget # show action executions for a code pipeline
bindkey '^[^b' fzf-s3-bucket-widget

# # Alt+Backspace to backward kill to dir segment
# use pb-backward-kill-word instead
# zle -N backward-kill-dir
# bindkey '^[^?' backward-kill-dir

# C-S--
bindkey '^_' copy-prev-shell-word

zle -N execute-buffer-in-nvim-widget
# works together with kitty send text
# terminals do not recognize ctrl enter - use kitty to send this instead
bindkey '^Ai' execute-buffer-in-nvim-widget

zle -N execute-buffer-with-git-show-widget
# bindkey '^[^m' execute-buffer-with-git-show-widget
# bindkey -s '^[^m' 'node index.mjs' 


zle -N edit-index-nvim-widget
# ctrl-, works with kitty map which maps ctrl- to ctrln
bindkey '^]' edit-index-nvim-widget
zle -N execute-index-node-widget
# ctrl+alt+-
bindkey '^[^]' execute-index-node-widget

zle -N execute-buffer-with-node-widget
# works with kitty map
bindkey '^J' execute-buffer-with-node-widget

zle -N fzf-chrome-bookmarks-widget
# bindkey '^[^m' fzf-chrome-bookmarks-widget
zle -N fzf-chrome-history-widget
# bindkey '^[^w' fzf-chrome-history-widget

zle -N fzf-yarn-widget
bindkey '^[w' fzf-yarn-widget

zle -N fzf-scratcher-cheat-widget
# bindkey '^[^s' fzf-scratcher-cheat-widget
# https://stackoverflow.com/questions/28819359/in-zsh-how-do-i-bind-a-keyboard-shortcut-to-run-the-last-command
# run the last command if pressing enter with empty buffer!!
# override the accept-line widget
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
# $WIDGET is a special variable that refers to the name of the currently executing widget
# run the built in accept line widget with .accept-line
accept-line() { [ -z "$BUFFER" ] && zle up-history; zle ".accept-line"; }
zle -N accept-line

zle     -N            fzf-my-file-widget
bindkey -M emacs '^T' fzf-my-file-widget
zle     -N            fzf-my-dir-widget
bindkey -M emacs '^[c' fzf-my-dir-widget
# bindkey -M emacs '^[^z' fzf-my-dir-widget
zle     -N            fzf-my-history-widget
bindkey -M emacs '^R' fzf-my-history-widget

zle     -N            test-widget
bindkey '^[^t'        test-widget
