alias u="tat" # tmux attach script
alias uu="tmux ls"
alias uk="tmux kill-session"
alias ux="tmux kill-server"
alias ut="tmux list-commands"

alias us="tmux list-sessions"
alias uw="tmux list-windows"
alias up="tmux list-panes"
alias udp="tmux display -p" # show format variables eg tmux display -p "{#pid}"

alias udpp="tmux display -p #{pane_id}" # show format variables eg tmux display -p "{#pid}"
alias udps="tmux display -p #{session_id}"
alias udpw="tmux display -p #{window_id}"

alias uk="tmux list-keys"

# show config
alias ucs="tmux show -s" # show server options
alias ucg="tmux show -g" # show global session options
alias ucgw="tmux show -gw" # show global window options
