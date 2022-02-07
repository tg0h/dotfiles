# directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
alias la='ls -lAh'
# lsd, exa
alias l='lsd -la' # -a show hidden files
alias ll='lsd -l' # use lsd to supercharge ls output
alias lll='exatd' # use lsd to supercharge ls output
alias lt="lsd -lt" # exclude hidden files to exclude . and ..
alias lr="lsd -lar" #reverse the sort
# exa
alias exat="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --no-user"
alias exatd="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"
alias exatl="exat --level"
alias exatal="exat --all --level" #include hidden and dot files
