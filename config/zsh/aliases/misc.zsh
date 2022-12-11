alias x='npx'
# alias n='which'
# alias al='autoload'
alias h='https'
alias j='lnav .'

alias which-command='which'

alias ccc='_fsc && zsh-compile-functions' # compile dir switcher and functions
alias zcf='zsh-compile-functions'

alias ag="alias | grep"
alias sg="set | grep"

alias rl=reload-function
alias th='trash'
alias tha='trash *'  # trash all files
alias th.='trash .*' # trash . files - needs both normal and . files to be present zzz
alias th..='trash * .*' # trash all files

alias pa='pbpaste'

alias ghd='gh dash'

alias f/='fsCheat' # show ud cheatsheet

# fscl collides with fswitch 
# alias fscl='fswitch configure list' # show ud configuration
alias fsce='fswitch configure edit' # edit ud configuration

alias eo='scratcher-cheat'

# quick print eval loop ====================================================
# nvim
alias ,="nvim"

# source from nvim cache
alias son="so -n"

alias vd="viddy"
alias db="dbxcli"
alias dbl="dbxcli ls"

alias ggw="gg -p $HOME/src/me/wiki" # commit changes to wiki
alias gpw="git -C $HOME/src/me/wiki push" # push changes to wiki

# utils ====================================================================
# bat
alias bats="bat *.csv"
alias bata="bat *(.)" # glob qualifier to only search for files, not dirs
alias batz="bat -A" # view whitespace

alias fu=funky
alias fua='funky -a'
alias fue='funky -e'
alias fur='funky -r'

alias fork="open . -a /Applications/Fork.app"
alias nm="neomutt"

alias norg="gron --ungron"

alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"

function take() {
# copied from oh-my-zsh/lib/functions.zsh
  mkdir -p $@ && cd ${@:$#}
}

# help
function manz(){
  # manz cd to read man for cd
  man zshbuiltins | less -p "^       $1 "
}
