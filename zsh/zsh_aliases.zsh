# GLOBAL ALIASES ==========================================================
alias -g F='| fzf' # change Z to whatever you like
alias -g T='| jq ".pay | fromjson"' # converT argus api stringifield payload back to json
alias -g G='| gron' 

# =========================================================================
# edit config file shortcuts
alias zshe='nvim ~/.env'
alias zshz='nvim ~/.zshenv'
alias zshrc='nvim ~/dotfiles/zshrc'

alias zshaa='nvim ~/.zsh/zsh_aliases.zsh'
alias zshf='nvim ~/.zsh/zsh_funcs.zsh' #misc functions, use zsh_functions folder for more organization

alias zshw='nvim ~/.ideanvimrc' # the webstorm ideanvim rc file

alias zshk='nvim ~/.config/kitty/kitty.conf' # the kitty config file

# mobile
alias zsha='nvim ~/.zsh/zsh_android.zsh'
alias zshi='nvim ~/.zsh/zsh_ios.zsh'

# dev
alias zshd='nvim ~/.zsh/zsh_docker_aliases.zsh'
alias zshn='nvim ~/.zsh/zsh_node.zsh'

# tools
alias zshfzf='nvim ~/.zsh/zsh_fzf.zsh' 

# git
alias zshgit='nvim ~/.zsh/zsh_git_aliases.zsh'
alias zshgitf='nvim ~/.zsh/zsh_fzf_git.zsh'

# devops, deployment
alias zshj='nvim ~/.zsh/zsh_jira.zsh'
alias zshg='nvim ~/.zsh/zsh_gitlab.zsh'
alias zshac='nvim ~/.zsh/zsh_appCenter.zsh'

# aws
alias zshrds='nvim ~/.zsh/aws/zsh_aws_rds.zsh'
alias zshcw='nvim ~/.zsh/aws/zsh_aws_cloudwatch.zsh'
alias zshc='nvim ~/.zsh/aws/zsh_aws_cognito.zsh'
alias zshct='nvim ~/.zsh/aws/zsh_aws_calltree.zsh'

# quick print eval loop ====================================================
# source
alias ss="source $HOME/dotfiles/scripts/scratch"
alias sss="source $HOME/.zshrc"
# edit
alias ee="nvim $HOME/dotfiles/scripts/scratch"

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
# nvim
alias eu="nvim"
