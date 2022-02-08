alias udcl='ud configure list' #show ud configuration
alias udce='ud configure edit' #edit ud configuration

# quick print eval loop ====================================================
# nvim
alias eu="nvim"

# source from nvim cache
alias son="so -n"

# source
alias ss="source $HOME/.local/lib/scratch.zsh"
alias sss="source $HOME/.config/zsh/.zshrc"

# edit
alias ee="nvim $HOME/.local/lib/scratch.zsh"

# bat
alias bats="bat *.csv"
alias bata="bat *(.)" # glob qualifier to only search for files, not dirs

# utils ====================================================================

alias ag="alias | grep"
alias sg="set | grep"

alias fork="open . -a /Applications/Fork.app"

alias norg="gron --ungron"

alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"

function take() {
# copied from oh-my-zsh/lib/functions.zsh
  mkdir -p $@ && cd ${@:$#}
}

