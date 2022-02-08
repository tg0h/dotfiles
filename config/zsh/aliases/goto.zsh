alias dt='cd /tmp'
alias dd='cd $HOME/dotfiles'

# zsh boot
alias zr='nvim ~/.dotfiles/config/zsh-boot/zshrc'
alias ze='nvim ~/.dotfiles/.env'
alias zz='nvim ~/.config/zsh/.zshenv'

# scratch
alias aes='nvim ~/certis/docs/wiki/scratch.md'
alias aesb='bat ~/certis/docs/wiki/scratch.md'


alias zaa='nvim $XDG_CONFIG_HOME/zsh/aliases/goto.zsh'
# config
alias zk='nvim ~/.config/kitty/kitty.conf'
alias zgit='nvim ~/.config/zsh/git.zsh'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'

# directories
alias d='dirs -v | head -n 10'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
alias la='ls -lAh'
alias md='mkdir -p'
alias rd=rmdir
