# alias c.='cd ~/src/playground/cdk'
alias c.='cd ~/src/playground/cdk/cdk-workshop'
alias c,='cd ~/src/playground/candy/referralcandy-secondary'
alias cs.='cd ./packages/common-services/scripts'

# relative change dir
alias apd='cd packages/daemons'

alias api='cd packages/infra'
alias app='cd packages/api/api'
alias apx='cd packages/external-api'
alias apei='cd packages/external-api/infra'
alias apri='cd packages/referralcorner/infra'

alias ada='cd packages/api/database_migrations/api'
alias acs='cd packages/common-services/scripts/timg'

# alias s.='cd ~/src/candy/main/referralcandy-main'
## global go to 
alias s.='cd ~/src/candy/referralcandy-main/main'
alias n.="cd ~/src/candy/referralcandy-main/main && nvim -c 'lua open_latest_changed_file()'"
alias s,='cd ~/src/candy/referralcandy-main/feature'
alias n,="cd ~/src/candy/referralcandy-main/feature && nvim -c 'lua open_latest_changed_file()'"
alias sr='cd ~/src/candy/referralcandy-main/review'
alias sp='cd ~/src/candy/referralcandy-main/play'
alias spi='cd ~/src/candy/referralcandy-main/play/packages/infra'
alias nr="cd ~/src/candy/referralcandy-main/review && nvim -c 'lua open_latest_changed_file()'"
alias sx='cd ~/src/candy/referralcandy-main/fix'
alias nx="cd ~/src/candy/referralcandy-main/fix && nvim -c 'lua open_latest_changed_file()'"
alias ss='cd ~/src/candy/referralcandy-main/scripts'
alias ns="cd ~/src/candy/referralcandy-main/scripts && nvim -c 'lua open_latest_changed_file()'"
# alias s..='cd ~/src/candy/main/referralcandy-main/packages/common-services/scripts/'
alias s..='cd ~/src/candy/referralcandy-main/scripts/packages/common-services/scripts/timg'
alias n..="cd ~/src/candy/referralcandy-main/scripts && nvim -c 'lua open_latest_changed_file()'"
alias s,.='cd ~/src/candy/referralcandy-main/feature/packages/redshift-services/scripts'
alias tp='cd ~/src/playground/playwright/'
alias dr='cd ~/src/candy/db/redshift-migration'

alias dt.='cd ~/Documents/tim'
# alias d.='dt'
alias d.='cd $HOME/dotfiles'
alias l.='cd $HOME/dotfiles/config/nvim/lua/tg' # my lua files
alias nd.="cd $HOME/dotfiles && nvim -c 'lua open_latest_changed_file()'"
alias d,='cd $HOME/dotfiles/config/nvim'
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
alias ,u='nvim ~/.config/zsh/aliases/git/git.zsh'
# alias zt='nvim ~/.config/tmux/tmux.conf'
alias zk='nvim $DOTFILES/config/kitty/kitty.conf'
alias zhd='nvim $DOTFILES/config/skhd/skhdrc'
alias zya='nvim $DOTFILES/config/yabai/yabairc'
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'

# scratch
alias zkt.='nvim ~/Desktop/tim/scratch.md'
