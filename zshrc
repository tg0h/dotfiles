# fonts - https://github.com/powerline/fonts.git
# iterm2 color scheme - aurora with black background

# this is important - you need to source the oh-my-zsh.sh file here

export ZSH="/Users/tim/.oh-my-zsh"
# set up p10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR='vim'
ZSH_THEME="powerlevel10k/powerlevel10k"
# COMPLETION_WAITING_DOTS="true" #display 3 dots while waiting for completion
# HIST_STAMPS="yyyy-mm-dd" # set up zsh history command date time format

# plugins
plugins=(
  zsh-nvm #add at the top so other plugins that use node/npm can work ###lukechilds/zsh-nvm
  adb aws colored-man-pages docker docker-compose dotenv #source the .env file in the root dir when you cd into it
  fasd git git-auto-fetch gitignore jira last-working-dir #lwd
  npm osx 
  ports ###github: github.com/caarlos0-graveyard/ports
  timer
  # vi-mode #interferes with prompt displaying modes, ctrl key special chars
  # web-search #google from command line
  zsh-autosuggestions ###zsh-users/zsh-autosuggestions
  zsh-autocomplete ###marlonrichert/zsh-autocomplete
  z
  # zsh-syntax-highlighting #source this at the end for syntax highlighting to work
  fast-syntax-highlighting ###zdharma/fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # p10k configuration

# zsh vim mode settings
# see http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html for the docs on the -v option
bindkey -v #use vim keymap for the zsh line editor - set vim key map first to allow other plugins to override keymap
export KEYTIMEOUT=1 # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
# bindkey -M vicmd "^V" edit-command-line # `v` is already mapped to visual mode, so we need to use a different key
# use hjkl to navigate zsh autocomplete menu
zmodload zsh/complist
# -M specifies the menuselect keymap for the command
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#remove ctrl g keybinding in the keymap so that junegunn's fzf_git functions work
bindkey -r "^G"

#zsh does not word split param expansions https://stackoverflow.com/questions/16200142/zsh-parameter-expansion-inserting-quotes
# setopt sh_word_split #turn on param expansion word split - this disables zsh autocompletion

# config
# add folders to path, not the executable!
complete -C '/usr/local/bin/aws_completer' aws # enable aws completion - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
export PATH="/usr/local/mysql/bin:$PATH" # add my sql to path
export PATH="/usr/local/opt/sqlite/bin:$PATH" # add homebrew sqlite3 to path (do not use macos sqlite which is an older version)
export PATH="$PATH:$HOME/dev/tools/flutter/bin" # add flutter
export PATH="$PATH:$HOME/Library/Android/sdk/emulator" # add android emulator
# export PATH="$PATH:/Users/tim/Library/Android/sdk/tools/bin" # add android emulator
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #source fzf after the vim keymap so fzf shortcuts take precedence

. ~/.zsh_aliases.zsh
. ~/.zsh_autosuggestions.zsh
. ~/.zsh_autocomplete.zsh
. ~/.zsh_docker_aliases.zsh
. ~/.zsh_fzf.zsh
. ~/.zsh_fzf_git.zsh
. ~/.zsh_git_aliases.zsh
. ~/.zsh_jira.zsh
. ~/.zsh_node.zsh
. ~/.zsh_toggl_aliases.zsh

# my functions
. ~/.env
. ~/.zsh_ios.zsh
. ~/.zsh_android.zsh
. ~/.zsh_gitlab.zsh

. ~/.zsh_aws_rds.zsh
. ~/.zsh_aws_cloudwatch.zsh
. ~/.zsh_aws_cognito.zsh
. ~/.zsh_aws_calltree.zsh

fpath+=~/.zsh_functions #add our own zsh functions directory to fpath
autoload -Uz ~/.zsh_functions/*(.) #-U supress alias expansion, -z zsh style function loading. (.) - glob qualifier. dot means show regular files only
autoload -U zmv # add the zsh zmv extension
. ~/.zsh_funcs.zsh #get all my functions

#load pyenv automatically
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# load my profiles
cerp p
