# exa
alias exaRecent="exa --header --created --changed --accessed --tree --long --icons --git --color always --octal-permissions --sort accessed --reverse --links --git --no-user --all"

alias x.="exaRecent --level 1"
alias x,="exaRecent --level 2"
alias x,.="exaRecent --level 3"

alias exad="exa --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"

alias exat="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --no-user"
alias exatl="exat --level"
alias exatal="exat --all --level" #include hidden and dot files

alias exatd="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"
