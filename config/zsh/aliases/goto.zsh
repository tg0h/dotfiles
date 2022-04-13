function dt(){
  mkdir -p /tmp/tim
  cd /tmp/tim
}
alias dd='cd $HOME/dotfiles'
alias dl='cd $HOME/downloads'
alias dp='cd /tmp'
alias dc='cd ~/src/clones'
alias dxd='cd $XDG_DATA_HOME'

alias od='cd $HOME/Documents/'
alias odd='cd $HOME/Documents/dev/'
alias odz='cd $HOME/Documents/dev/candy/invite-customers/'

alias udscm='cd $HOME/src/candy/referralcandy-main/'

# candy wiki - old
alias nh='nvim ~/Documents/candy/wiki/old/readme.md'

# zsh boot
alias zr='nvim ~/.dotfiles/config/zsh-boot/zshrc'
alias zz='nvim ~/.config/zsh/.zshenv'
alias ze='nvim ~/.dotfiles/config/secret/env'

# scratch
alias aes='nvim ~/certis/docs/wiki/scratch.md'
alias aesb='bat ~/certis/docs/wiki/scratch.md'

# aliases
alias zag='nvim $XDG_CONFIG_HOME/zsh/aliases/goto.zsh'
alias zam='nvim $XDG_CONFIG_HOME/zsh/aliases/misc.zsh'
alias zad='nvim $XDG_CONFIG_HOME/zsh/aliases/docker.zsh'
alias zac='nvim $XDG_CONFIG_HOME/zsh/aliases/candy.zsh'

# config
alias zg='nvim ~/.config/zsh/aliases/git/git.zsh'
alias zt='nvim ~/.config/tmux/tmux.conf'
alias zk='nvim ~/.config/skhd/skhdrc'
alias zy='nvim ~/.config/yabai/yabairc'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'
