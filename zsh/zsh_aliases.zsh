# GLOBAL ALIASES ==========================================================
alias -g F='| fzf' # change Z to whatever you like
alias -g T='| jq ".pay | fromjson"' # converT argus api stringifield payload back to json
alias -g G='| gron' 

# =========================================================================
# edit config file shortcuts
alias zshe='vim ~/.env'
alias zshrc='vim ~/dotfiles/zshrc'

alias zshaa='vim ~/.zsh/zsh_aliases.zsh'
alias zshf='vim ~/.zsh/zsh_funcs.zsh' #misc functions, use zsh_functions folder for more organization

alias zshw='vim ~/.ideavimrc' # the webstorm ideavim rc file

# mobile
alias zsha='vim ~/.zsh/zsh_android.zsh'
alias zshi='vim ~/.zsh/zsh_ios.zsh'

# dev
alias zshd='vim ~/.zsh/zsh_docker_aliases.zsh'
alias zshn='vim ~/.zsh/zsh_node.zsh'

# tools
alias zshfzf='vim ~/.zsh/zsh_fzf.zsh' 

# git
alias zshgit='vim ~/.zsh/zsh_git_aliases.zsh'
alias zshgitf='vim ~/.zsh/zsh_fzf_git.zsh'

# devops, deployment
alias zshj='vim ~/.zsh/zsh_jira.zsh'
alias zshg='vim ~/.zsh/zsh_gitlab.zsh'
alias zshac='vim ~/.zsh/zsh_appCenter.zsh'

# aws
alias zshrds='vim ~/.zsh/aws/zsh_aws_rds.zsh'
alias zshcw='vim ~/.zsh/aws/zsh_aws_cloudwatch.zsh'
alias zshc='vim ~/.zsh/aws/zsh_aws_cognito.zsh'
alias zshct='vim ~/.zsh/aws/zsh_aws_calltree.zsh'

# quick print eval loop ====================================================
# source
alias ss="source $HOME/dotfiles/scripts/scratch"
alias sss="source $HOME/.zshrc"
# edit
alias ee="vim $HOME/dotfiles/scripts/scratch"

# others ====================================================================
alias norg="gron --ungron"

alias l='lsd -la' # -a show hidden files
alias ll='lsd -l' # use lsd to supercharge ls output
alias lt="lsd -lat"
alias lr="lsd -lar" #reverse the sort
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
alias exat="exa --tree --long --icons --git"
# vim
alias vim="nvim"
alias oldvim="\vim"
