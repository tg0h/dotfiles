alias x="tat" # tmux attach script
alias xu="tmux ls"
alias xx="tmux kill-server"
alias xt="tmux list-commands"
alias x="fzf_tmux_create_or_switch_session"

alias xs="x x"
alias xw="tmux list-windows"
alias xp="tmux list-panes"
alias xdp="tmux display -p" # show format variables eg tmux display -p "{#pid}"

alias xdpp="tmux display -p #{pane_id}" # show format variables eg tmux display -p "{#pid}"
alias xdps="tmux display -p #{session_id}"
alias xdpw="tmux display -p #{window_id}"

alias xk="tmux list-keys"

# show config
alias xcs="tmux show -s" # show server options
alias xcg="tmux show -g" # show global session options
alias xcgw="tmux show -gw" # show global window options
