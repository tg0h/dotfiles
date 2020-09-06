export ZSH="/Users/tim/.oh-my-zsh"

# set up p10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR='vim'
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
  # vi-mode #interferes with prompt displaying modes, ctrl key special chars
  # web-search #google from command line
  zsh-autosuggestions
  zsh-autocomplete
  z
  zsh-syntax-highlighting #source this at the end for syntax highlighting to work
)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # p10k configuration

# zsh vim mode settings
bindkey -v #use vim keymap for the zsh line editor - set vim key map first to allow other plugins to override keymap
export KEYTIMEOUT=1 # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
bindkey -M vicmd "^V" edit-command-line # `v` is already mapped to visual mode, so we need to use a different key
# use hjkl to navigate zsh autocomplete menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# alias
alias j=jira
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias zshrc='vim ~/.zshrc'
alias zshrds='vim ~/dotfiles/zsh_aws_rds'
alias zshcw='vim ~/.zsh_aws_cloudwatch'
alias zshc='vim ~/.zsh_aws_cognito'
alias topten="history | commands | sort -rn | head"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
alias usage='du -h -d1'
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias sshdir="cd ~/.ssh"
alias runp="lsof -i " #eg runp :1234 tells you whether port 1234 is being used
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"
# - task aliases
alias tcn='task context none'
alias tcw='task context work'
## search task tags
alias ttt='task tag~tooling'

##certify
alias ccc="cd $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER"

alias tws='timew summary'
alias twsi='timew summary :id'
alias twu='timew untag' #@1 <tag to remove>
alias twh='timew shorten' #h,min https://timewarrior.net/docs/duration.html
alias twl='timew lengthen' #h,min https://timewarrior.net/docs/duration.html
alias twms='timew modify start'
alias twme='timew modify end'

#zsh does not word split param expansions https://stackoverflow.com/questions/16200142/zsh-parameter-expansion-inserting-quotes
setopt sh_word_split #turn on param expansion word split

# config
complete -C '/usr/local/bin/aws_completer' aws # enable aws completion - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
export PATH="/usr/local/mysql/bin:$PATH" # add my sql to path
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #source fzf after the vim keymap so fzf shortcuts take precedence
. ~/.zsh_autosuggestions
. ~/.zsh_autocomplete
. ~/.zsh_docker_aliases
. ~/.zsh_fzf
. ~/.zsh_fzf_git
. ~/.zsh_git_aliases
. ~/.zsh_jira

# my functions
. ~/.zsh_aws_rds
. ~/.zsh_aws_cloudwatch
. ~/.zsh_aws_cognito
fpath+=~/.zsh_functions #add our own zsh functions directory to fpath
autoload -Uz ~/.zsh_functions/*(.) #-U supress alias expansion, -z zsh style function loading. (.) - glob qualifier. dot means show regular files only
. ~/.zsh_funcs #get all my functions


function rgs(){
  rg $1 --sortr created
}
