# GLOBAL ALIASES ==========================================================
alias -g F='| fzf' # change Z to whatever you like

# =========================================================================
# edit config file shortcuts
alias zshrc='vim ~/.zshrc'
alias zshaa='vim ~/.zsh_aliases.zsh'
alias zshf='vim ~/.zsh_funcs.zsh' #misc functions, use zsh_functions folder for more organization
alias zshe='vim ~/.env'

alias zshw='vim ~/.ideavimrc' # the webstorm ideavim rc file

alias zsha='vim ~/.zsh_android.zsh'
alias zshi='vim ~/.zsh_ios.zsh'
alias zshn='vim ~/.zsh_node.zsh'
alias zshfzf='vim ~/.zsh_fzf.zsh' 
alias zshg='vim ~/.zsh_gitlab.zsh'

alias zshgit='vim ~/.zsh_git_aliases.zsh'
alias zshgitf='vim ~/.zsh_fzf_git.zsh'

alias zshrds='vim ~/.zsh_aws_rds.zsh'
alias zshcw='vim ~/.zsh_aws_cloudwatch.zsh'
alias zshc='vim ~/.zsh_aws_cognito.zsh'
alias zshct='vim ~/.zsh_aws_calltree.zsh'


# others ====================================================================
alias ls='lsd' #use lsd to supercharge ls output

alias lt="l -t"

alias ee="source $HOME/dotfiles/scripts/scratch"
alias eee="vim $HOME/dotfiles/scripts/scratch"


alias j=jira
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias kraken="open . -a /Applications/GitKraken.app"
alias topten="history | commands | sort -rn | head"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
alias usage='du -h -d1'
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias sshdir="cd ~/.ssh"
alias runp="lsof -i " #eg runp :1234 tells you whether port 1234 is being used
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"
