function dt(){
  mkdir -p /tmp/tim
  cd /tmp/tim
}
alias dd='cd $HOME/dotfiles'

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
alias zt='nvim ~/.config/tmux/tmux.conf'
alias zk='nvim ~/.config/kitty/kitty.conf'
alias zg='nvim ~/.config/zsh/aliases/git/git.zsh'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'
