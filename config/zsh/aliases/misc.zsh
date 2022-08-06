alias h='which'

alias which-command='which'

alias ag="alias | grep"
alias sg="set | grep"

alias rl=reload-function
alias th='trash'

alias pa='pbpaste'

alias ghd='gh dash'

alias f/='fsCheat' # show ud cheatsheet
alias fscl='fswitch configure list' # show ud configuration
alias fsce='fswitch configure edit' # edit ud configuration

# quick print eval loop ====================================================
# nvim
alias eu="nvim"

# source from nvim cache
alias son="so -n"

# source
alias ss="source $HOME/.local/bin/scratch"

# edit
alias ee="nvim $HOME/.local/bin/scratch"
alias uu="nvim $HOME/.local/bin/scratch.js"
alias unt="echo $HOME/.local/bin/scratch.js | entr -c node $HOME/.local/bin/scratch.js"
# watch for changes to scratch, then clear screen and run scratch
alias ent="echo $HOME/.local/bin/scratch | entr -c scratch"
alias vs="viddy scratch"
alias oe="nvim $HOME/.local/lib/scratch.lua"
alias ou="lua $HOME/.local/lib/scratch.lua"

alias db="dbxcli"
alias dbl="dbxcli ls"

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
