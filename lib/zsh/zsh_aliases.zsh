# GLOBAL ALIASES ==========================================================
alias -g F='| fzf' # change Z to whatever you like
alias -g T='| jq ".pay | fromjson"' # converT argus api stringifield payload back to json
alias -g G='| gron' 
alias -g L='| wc -l' 
alias -g J='| jq .' 
# =========================================================================
# edit config file shortcuts
alias doi='dotbot --verbose -c install.conf.yaml'
alias zshr='nvim ~/dotfiles/config/env/zshrc'
alias zshe='nvim ~/.env'
alias zshz='nvim ~/.zshenv'
alias zshaa='nvim ~/.local/lib/zsh/zsh_aliases.zsh'
alias zshf='nvim ~/local/lib/zsh/zsh_funcs.zsh' #misc functions, use zsh_functions folder for more organization
alias zshk='nvim ~/.config/kitty/kitty.conf' # the kitty config file
# mobile
alias zsha='nvim ~/.local/lib/zsh/android/misc.zsh'
alias zshi='nvim ~/.local/lib/zsh/zsh_ios.zsh'
# tools
alias zshd='nvim ~/.local/lib/zsh/zsh_docker_aliases.zsh'
alias zshfzf='nvim ~/.local/lib/zsh/zsh_fzf.zsh' 
alias zshrc='nvim ~/.local/lib/zsh/redis.zsh'
# git
alias zshgit='nvim ~/.local/lib/zsh/zsh_git_aliases.zsh'
alias zshgitf='nvim ~/.local/lib/zsh/zsh_fzf_git.zsh'
# devops, deployment
alias zshj='nvim ~/.local/lib/zsh/zsh_jira.zsh'
alias zshg='nvim ~/.local/lib/zsh/zsh_gitlab.zsh'
alias zshac='nvim ~/.local/lib/zsh/zsh_appCenter.zsh'
# aws
alias zshrds='nvim ~/.local/lib/zsh/aws/zsh_aws_rds.zsh'
alias zshcw='nvim ~/.local/lib/zsh/aws/zsh_aws_cloudwatch.zsh'
alias zshc='nvim ~/.local/lib/zsh/aws/zsh_aws_cognito.zsh'
alias zshct='nvim ~/.local/lib/zsh/aws/zsh_aws_calltree.zsh'
# quick print eval loop ====================================================
# nvim
alias eu="nvim"
# source from nvim cache
alias son="so -n"
# source
alias ss="source $HOME/.local/lib/scratch"
alias sss="source $HOME/.zshrc"
# edit
alias ee="nvim $HOME/.local/lib/scratch"
# dir   ====================================================================
alias l='lsd -la' # -a show hidden files
alias ll='lsd -l' # use lsd to supercharge ls output
alias lt="lsd -lat"
alias lr="lsd -lar" #reverse the sort
# exa
alias exat="exa --tree --long --icons --git"
# utils ====================================================================
#zsh jira plugin
alias j=jira
alias zt="cd /tmp"
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias norg="gron --ungron"
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"
