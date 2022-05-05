alias t="tat" # tmux attach script
alias tu="tmux ls"
alias tk="tmux kill-session"
alias tx="tmux kill-server"
alias ttl="tmux list-commands"

alias ts="tmux list-sessions"
alias tw="tmux list-windows"
alias tp="tmux list-panes"
alias tdp="tmux display -p" # show format variables eg tmux display -p "{#pid}"

alias tdpp="tmux display -p #{pane_id}" # show format variables eg tmux display -p "{#pid}"
alias tdps="tmux display -p #{session_id}"
alias tdpw="tmux display -p #{window_id}"

alias tk="tmux list-keys"

# show config
alias tcs="tmux show -s" # show server options
alias tcg="tmux show -g" # show global session options
alias tcgw="tmux show -gw" # show global window options
