# https://unix.stackexchange.com/questions/147563/how-do-i-repeat-the-last-command-without-using-the-arrow-keys
function hh(){
  # repeat the last command
  # oops, it's much easier in zsh to just use vi mode, ESC-k
  # (go to command mode and press k for up)
  fc -e -
}

function hhh(){
  # repeat the second last command
  # oops, it's much easier in zsh to just use vi mode, ESC-k
  # (go to command mode and press k for up)
  fc -e - -2
}

function hi(){
  # list previous commands
  # note - running aoeu itself adds a command to the command history :|
  fc -l
}

function hist(){
  # list commands with timestamp with seconds
  # fc -lf
  history -t '%F %T'
}
