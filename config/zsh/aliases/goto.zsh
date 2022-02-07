alias zsht='cd /tmp'

# zsh boot
alias zshr='nvim ~/.dotfiles/config/zsh-boot/zshrc'
alias zshe='nvim ~/.dotfiles/.env'
alias zshz='nvim ~/.config/zsh/.zshenv'

# scratch
alias aes='nvim ~/certis/docs/wiki/scratch.md'
alias aesb='bat ~/certis/docs/wiki/scratch.md'


alias zshaa='nvim $XDG_CONFIG_HOME/zsh/aliases/goto.zsh'
# config
alias zshk='nvim ~/.config/kitty/kitty.conf' # the kitty config file
alias zshgit='nvim ~/.config/zsh/git.zsh'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'

# directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
alias la='ls -lAh'
