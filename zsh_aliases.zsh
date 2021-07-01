# GLOBAL ALIASES ==========================================================
alias -g F='| fzf' # change Z to whatever you like

# =========================================================================
# edit config file shortcuts
alias zshrc='vim ~/dotfiles/zshrc'
alias zshaa='vim ~/.zsh_aliases.zsh'
alias zshf='vim ~/.zsh_funcs.zsh' #misc functions, use zsh_functions folder for more organization
alias zshe='vim ~/.env'

alias zshw='vim ~/.ideavimrc' # the webstorm ideavim rc file

# mobile
alias zsha='vim ~/.zsh_android.zsh'
alias zshi='vim ~/.zsh_ios.zsh'

# dev
alias zshd='vim ~/.zsh_docker_aliases.zsh'
alias zshn='vim ~/.zsh_node.zsh'

# tools
alias zshfzf='vim ~/.zsh_fzf.zsh' 

# git
alias zshgit='vim ~/.zsh_git_aliases.zsh'
alias zshgitf='vim ~/.zsh_fzf_git.zsh'

# devops, deployment
alias zshj='vim ~/.zsh_jira.zsh'
alias zshg='vim ~/.zsh_gitlab.zsh'
alias zshac='vim ~/.zsh_appCenter.zsh'

# aws
alias zshrds='vim ~/.zsh_aws_rds.zsh'
alias zshcw='vim ~/.zsh_aws_cloudwatch.zsh'
alias zshc='vim ~/.zsh_aws_cognito.zsh'
alias zshct='vim ~/.zsh_aws_calltree.zsh'

# others ====================================================================
alias l='lsd -lah' #use lsd to supercharge ls output
alias ll='lsd -lh' #use lsd to supercharge ls output
alias lt="lsd -laht"

# quick print eval loop ====================================================
# source
alias ss="source $HOME/dotfiles/scripts/scratch"
alias sss="source $HOME/.zshrc"
# edit
alias ee="vim $HOME/dotfiles/scripts/scratch"

#zsh jira plugin
alias j=jira
alias zt="cd /tmp"
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"

# exa
alias exat="exa --tree --long"
