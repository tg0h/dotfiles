function dt(){
  mkdir -p /tmp/tim
  cd /tmp/tim
}
alias dt.='cd ~/Documents/tim'
alias d.='cd $HOME/dotfiles'
alias dd='cd $HOME/dotfiles'
alias dl='cd $HOME/downloads'
# alias dp='cd /tmp' - use :t instead
# alias dc='cd ~/src/clones'
# alias dw='cd ~/src/me/wiki' - use :w
# alias dxd='cd $XDG_DATA_HOME'

alias u/='uxs'
alias :/=':xs'

# alias udscm='cd $HOME/src/candy/referralcandy-main/'

# candy wiki - old
alias vh='nvim ~/Documents/candy/wiki/old/readme.md'

# zsh boot
alias z,.='nvim ~/.dotfiles/config/secret/env'
alias z.='nvim ~/.config/zsh/.zshenv'
alias z,='nvim ~/.dotfiles/config/zsh-boot/zshrc'

# scratch
# alias aes='nvim ~/certis/docs/wiki/scratch.md'
# alias aesb='bat ~/certis/docs/wiki/scratch.md'

# aliases
alias zag='nvim $XDG_CONFIG_HOME/zsh/aliases/goto.zsh'
alias zaG='nvim $XDG_CONFIG_HOME/zsh/aliases/global.zsh'
alias zam='nvim $XDG_CONFIG_HOME/zsh/aliases/misc.zsh'
alias zas='nvim $XDG_CONFIG_HOME/zsh/aliases/scratch.zsh'
alias sas='source $XDG_CONFIG_HOME/zsh/aliases/scratch.zsh && echo sourced aliases/scratch.zsh'
# alias zad='nvim $XDG_CONFIG_HOME/zsh/aliases/docker.zsh'
alias sad='source $XDG_CONFIG_HOME/zsh/aliases/docker.zsh && echo sourced aliases/kubernetes.zsh'
alias zak='nvim $XDG_CONFIG_HOME/zsh/aliases/kubernetes.zsh'
alias sak='source $XDG_CONFIG_HOME/zsh/aliases/kubernetes.zsh && echo sourced aliases/kubernetes.zsh'
alias zac='nvim $XDG_CONFIG_HOME/zsh/aliases/candy.zsh'

# config
alias zt='nvim ~/.config/tg/scratcher/config.yml'
alias zg='nvim ~/.config/zsh/aliases/git/git.zsh'
# alias zt='nvim ~/.config/tmux/tmux.conf'
alias zk='nvim ~/.config/kitty/kitty.conf'
alias zh='nvim ~/.config/skhd/skhdrc'
alias zy='nvim ~/.config/yabai/yabairc'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'
