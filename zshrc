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
alias ee="source $HOME/dotfiles/scripts/scratch"
alias eee="vim $HOME/dotfiles/scripts/scratch"

alias j=jira
alias ag="alias | grep"
alias sg="set | grep"
alias fork="open . -a /Applications/Fork.app"
alias topten="history | commands | sort -rn | head"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
alias usage='du -h -d1'
# alias update="source ~/.zshrc" #doesn't work - complains about some fd error
alias sshdir="cd ~/.ssh"
alias runp="lsof -i " #eg runp :1234 tells you whether port 1234 is being used
alias vpn="networksetup -connectpppoeservice 'edo vpn'"
alias dvpn="networksetup -disconnectpppoeservice 'edo vpn'"

# NODE ==========================================================================
function ns() {
  open http://localhost:4200
  npm run serve_local
}
function nt() { nvm use 10 }
function ntt() { nvm use 14 }

# ADB ==========================================================================
function aip() {
  adb -d shell ip route
}
function atcp() {
  adb -d tcpip 5555
}
function acon() {
  # adb -d tcpip 5555
  adb -d connect 192.168.1.$1:5555
  # scrcpy -s 192.168.1.$1:5555
}

function ashow() {
  adb -d tcpip 5555
  adb -d connect 192.168.1.$1:5555
  scrcpy -s 192.168.1.$1:5555
}

#what are my devices
function add() {
  adb devices
}

function adi() {
  adb -s 192.168.1.$1:5555 install $2
}

# install ios ipa
function idi() {
  ideviceinstaller -i $1
}

#what are the pids of the argus app?
function ads() {
  adb shell ps | rg argus
}

#pass a pid to logcat
function adll() {
  adb logcat --pid $1 -v time -v color
}

#run logcat immediately
# -a - which app d,s,p or fd,fs,fp
# -e - regex to search message
# -l - which log level v,d,i,w,e,f
function adl() {
  local loglevel=v
  local regex=".*" #default
  local app=""

  while getopts 'l:e:a:' opt; do
    case "$opt" in
      l) loglevel=$OPTARG ;;
      e) regex=$OPTARG ;;
      a) app=$OPTARG 
        case "$app" in
          d) appId="com.certis.argus.apps.officer.dev";;
          s) appId="com.certis.argus.apps.officer.staging";;
          p) appId="com.certis.argus.apps.officer$";; #prod - regex checks for end of string
          fd) appId="com.certisgroup.argus.apps.officer.dev";; #flutter dev
          fs) appId="com.certisgroup.argus.apps.officer.staging";; #flutter staging
          fp) appId="com.certisgroup.argus.apps.officer$";; #flutter prod
        esac
        ;;
    esac
  done
  shift $(($OPTIND - 1))

  #if -a app argument not given, get the pid of the first app named argus 
  if [[ -z "$appId" ]]
  then
    appId="argus"
  fi

  local pid=$(adb shell ps | rg $appId | gawk 'NR==1{print $2}')

  echo connecting to app $appId with pid $pid with regex $regex
  adb logcat "*:$loglevel" --pid $pid -v time -v color -e $regex
}



# SCRCPY ==========================================================================
function sc() {
  scrcpy -s 192.168.1.$1:5555
}

# edit config file shortcuts
alias zsha='vim ~/.zsh_android'
alias zshi='vim ~/.zsh_ios'

alias zshrc='vim ~/.zshrc'
alias zshgit='vim ~/.zsh_git_aliases'
alias zshrds='vim ~/dotfiles/zsh_aws_rds'
alias zshcw='vim ~/.zsh_aws_cloudwatch'
alias zshc='vim ~/.zsh_aws_cognito'
alias zshct='vim ~/.zsh_aws_calltree'

# rg shortcuts
function rgs(){ rg $1 --sortr created }

function ffm() {
  ffmpeg -i $1 -vcodec libx265 -crf 28 "$1"-out.mp4
}

#zsh does not word split param expansions https://stackoverflow.com/questions/16200142/zsh-parameter-expansion-inserting-quotes
# setopt sh_word_split #turn on param expansion word split - this disables zsh autocompletion

# config
complete -C '/usr/local/bin/aws_completer' aws # enable aws completion - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
export PATH="/usr/local/mysql/bin:$PATH" # add my sql to path
export PATH="/usr/local/opt/sqlite/bin:$PATH" # add homebrew sqlite3 to path (do not use macos sqlite which is an older version)
export PATH="$PATH:/Users/tim/dev/tools/flutter/bin" # add flutter
export PATH="$PATH:/Users/tim/Library/Android/sdk/emulator" # add android emulator
# export PATH="$PATH:/Users/tim/Library/Android/sdk/tools/bin" # add android emulator
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #source fzf after the vim keymap so fzf shortcuts take precedence

. ~/.zsh_autosuggestions
. ~/.zsh_autocomplete
. ~/.zsh_docker_aliases
. ~/.zsh_fzf
. ~/.zsh_fzf_git
. ~/.zsh_git_aliases
. ~/.zsh_jira
. ~/.zsh_toggl_aliases

# my functions
. ~/.zsh_ios
. ~/.zsh_android
. ~/.zsh_aws_rds
. ~/.zsh_aws_cloudwatch
. ~/.zsh_aws_cognito
. ~/.zsh_aws_calltree

fpath+=~/.zsh_functions #add our own zsh functions directory to fpath
autoload -Uz ~/.zsh_functions/*(.) #-U supress alias expansion, -z zsh style function loading. (.) - glob qualifier. dot means show regular files only
. ~/.zsh_funcs #get all my functions

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
