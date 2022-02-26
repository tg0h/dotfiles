setopt autopushd
setopt pushd_ignore_dups

# invert the meaning of + and - when using cd -1
# normally, cd -0 means go to the rightmost entry of dirs -v -l
setopt pushdminus 

# directories
function d () {
  # if we detect an option, then pass all options to dirs
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}

# compdef won't work because of zinit?
# compdef _dirs d

alias pd=popd

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'

# see man zshbuiltins and search for cd
# cd ~1 does the same thing as cd -1?
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
