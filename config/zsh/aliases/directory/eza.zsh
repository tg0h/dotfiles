# eza
alias ezaRecent="eza --header --created --changed --accessed --tree --long --icons --git --color always --octal-permissions --sort accessed --reverse --links --git --no-user --all"

alias x.="ezaRecent --level 1"
alias x,="ezaRecent --level 2"
alias x,.="ezaRecent --level 3"

alias ezad="eza --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"

alias ezat="eza --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --no-user"
alias ezatl="exat --level"
alias ezatal="exat --all --level" #include hidden and dot files

alias ezatd="eza --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"
