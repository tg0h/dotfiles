# TODO: how to cache nvim files if accessed via alias
# TODO: alias fzf manager - with comments
#tmp GLOBAL ALIASES ==========================================================
alias -g F='| fzf --preview-window hidden'
alias -g T='| jq ".pay | fromjson"' # converT argus api stringifield payload back to json
alias -g G='| gron --colorize'
alias -g W='| wc -l'
alias -g J='| jq .'
# history
alias 11="!!" # repeat last command
alias 111="!-2" # repeat second last command
# =========================================================================
alias udcl='ud configure list' #show ud configuration
alias udce='ud configure edit' #edit ud configuration
# edit config file shortcuts
alias dos='nvim ~/.dotfiles/install.conf.yaml' # dotbot sourcefile
alias doi='dotbot --verbose -c ~/.dotfiles/install.conf.yaml'
alias zshr='nvim ~/.dotfiles/config/zsh-boot/zshrc'
alias zshe='nvim ~/.dotfiles/.env'
alias zshz='nvim ~/.config/zsh/.zshenv'
alias zshaa='nvim $XDG_CONFIG_HOME/zsh/zsh_aliases.zsh'

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
alias zshgit='nvim ~/.config/zsh/git_aliases.zsh'
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
##certify
ccon() { sqlite3 $_CERTIFY_VERIFY_DB }
# quick print eval loop ====================================================
# nvim
alias eu="nvim"
# source from nvim cache
alias son="so -n"
# source
alias ss="source $HOME/.local/lib/scratch.zsh"
alias sss="source $HOME/.config/zsh/.zshrc"
# edit
alias ee="nvim $HOME/.local/lib/scratch.zsh"
# dir   ====================================================================
alias l='lsd -la' # -a show hidden files
alias ll='lsd -l' # use lsd to supercharge ls output
alias lll='exatd' # use lsd to supercharge ls output
alias lt="lsd -lt" # exclude hidden files to exclude . and ..
alias lr="lsd -lar" #reverse the sort
# exa
alias exat="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --no-user"
alias exatd="exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --links --git --binary --blocks --header --inode --created --changed --classify"
alias exatl="exat --level"
alias exatal="exat --all --level" #include hidden and dot files
# bat
alias bats="bat *.csv"
alias bata="bat *"
# utils ====================================================================
#zsh jira plugin
alias j=jira
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias norg="gron --ungron"
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"
# slack
alias sl=slackcat
alias sld="slackcat --channel dominicsq_soh"
alias slt="slackcat --channel ***REMOVED***"
alias sln="slackcat --channel nashtech-dev"
alias sll="slackcat --list"
#ide
alias ws=webstorm
