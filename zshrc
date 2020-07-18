# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tim/.oh-my-zsh"
export PATH="/usr/local/mysql/bin:$PATH"

# COMPLETION
## set up message format
# zstyle ':completion:*' format %d
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format %d
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*' group-name '' #add groups to display
# zstyle ':completion:*' completer _expand _complete _correct #auto correct
#zstyle ':completion:*' verbose yes #command options show descriptions

fpath+=~/.zsh_functions #add our own zsh functions directory to fpath

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    adb
    aws
    colored-man-pages
    jira
    npm
    #git
    git-auto-fetch
    gitignore
    docker
    timer
    vi-mode
    zsh-autosuggestions
    zsh-autocomplete
    z
    zsh-syntax-highlighting
    #zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ag="alias | grep"
alias fork="open . -a /Applications/Fork.app"

. ~/.zsh_git_aliases
. ~/.zsh_docker_aliases
. ~/.zsh_autocomplete
. ~/.zsh_fzf
. ~/.zsh_fzf_git
. ~/.zsh_jira

#nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function cget() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | {Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}'
}

function cgetcsv() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq --raw-output '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @csv'
}

function cgetcsvrow() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq --raw-output '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | map([.[ $keys[] ]])[] | @csv'
}

function cgetall() {
  if (( $# == 0 ));
  then echo "no args passed!"
  else
    echo "Username","UserStatus","phone_number_verified","phone_number","email_verified","email","company_email","personal_email","UserLastModified"
    for i
      # if (( i == 1)); then
      #   echo 1
      # fi
      do cgetcsvrow $i
    done
  fi
}

function cgets() {
  aws cognito-idp admin-list-user-auth-events  --user-pool-id ap-southeast-1_Q5BSv9IX7 --username SG$1 | jq '.AuthEvents[0:6][] | {EventResponse,EventType,CreationDate}'
}
