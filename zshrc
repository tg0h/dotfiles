export ZSH="/Users/tim/.oh-my-zsh"

# set up p10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true" #display 3 dots while waiting for completion
HIST_STAMPS="yyyy-mm-dd" # set up zsh history command date time format

# plugins
plugins=(
    zsh-nvm #add at the top so other plugins that use node/npm can work
    adb
    aws
    colored-man-pages
    docker
    dotenv #source the .env file in the root dir when you cd into it
    git
    git-auto-fetch
    gitignore
    jira #jira from command line
    last-working-dir #lwd
    npm
    osx
    timer
    vi-mode
    web-search #google from command line
    zsh-autosuggestions
    zsh-autocomplete
    z
    zsh-syntax-highlighting #source this at the end for syntax highlighting to work
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # p10k configuration

# user configuration
fpath+=~/.zsh_functions #add our own zsh functions directory to fpath
autoload -Uz ~/.zsh_functions/*(.) #-U supress alias expansion, -z zsh style function loading. (.) - glob qualifier. dot means show regular files only

export PATH="/usr/local/mysql/bin:$PATH"
export EDITOR='vim'

# alias 
alias ag="alias | grep"
alias fork="open . -a /Applications/Fork.app"
alias zshrc='vim ~/.zshrc'
alias zshrds='vim ~/dotfiles/zsh_aws_rds'
alias zshcw='vim ~/.zsh_aws_cloudwatch'
alias topten="history | commands | sort -rn | head"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
alias usage='du -h -d1'
alias update="source ~/.zshrc"
alias sshdir="cd ~/.ssh"
alias runp="lsof -i " #eg runp :1234 tells you whether port 1234 is being used
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"

. ~/.zsh_autocomplete
. ~/.zsh_docker_aliases
. ~/.zsh_fzf
. ~/.zsh_fzf_git
. ~/.zsh_git_aliases
. ~/.zsh_jira

# my functions
. ~/.zsh_aws_rds
. ~/.zsh_aws_cloudwatch

. ~/.zsh_funcs #get all my functions

function sa {
  local pre=:
  local post=:
  printf "$pre%s$post\n" "$@" 
}
