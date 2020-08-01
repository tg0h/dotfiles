# set up p10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
export ZSH="/Users/tim/.oh-my-zsh"
export PATH="/usr/local/mysql/bin:$PATH"

fpath+=~/.zsh_functions #add our own zsh functions directory to fpath

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true" #display 3 dots while waiting for completion
HIST_STAMPS="yyyy-mm-dd" # set up zsh history command date time format

# plugins
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
    zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'

# alias 
alias ag="alias | grep"
alias fork="open . -a /Applications/Fork.app"

. ~/.zsh_git_aliases
. ~/.zsh_docker_aliases
. ~/.zsh_autocomplete
. ~/.zsh_fzf
. ~/.zsh_fzf_git
. ~/.zsh_jira

#import tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# eval "$(zoxide init zsh)" #use zoxide

#get from prod
function cget() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | {Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}'
}

#get from staging
function cgetst() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_bbe9csnbP --username "SG$1" | jq '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | {Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}'
}

# get column headers as well as values
# function cgetcsv() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq --raw-output '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @csv'
# }

#get the user values without the column headers
function cgetcsvrow() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq --raw-output '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username,UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | map([.[ $keys[] ]])[] | @csv'
}

function cgetcsv() {
  if (( $# == 0 ));
  then echo "no args passed!"
  else
    echo '"Username","UserStatus","phone_number_verified","phone_number","email_verified","email","company_email","personal_email","UserLastModified"'
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
