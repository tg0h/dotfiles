# cred stash
alias clc="~/src/candy/old/candymold/tools/list-credentials.js" # credstash
alias cgc="~/src/candy/old/candymold/tools/get-credential.js" # credstash

# cognito
# CC
alias cclud="cclu dev | fzf -q 'timothyg'" # list users
alias cclus="cclu staging | fzf -q 'timothyg'" # list users
alias cccud="cccu -s dev -c" # create users
alias cccus="cccu -s staging -c"

alias ccdud="ccdu -s dev" # delete users
alias ccsud="ccdu -s staging"

# rc main environment
# CE
alias cedl="ced -l" # point to local db
alias ceds="ced -s" # point to staging db
alias cefl="cef -l" # turn off mocking
alias cefm="cef -m" # turn on mocking

# docker composer 
# CDC
alias cdcu="docker compose -f $CANDY_COMPOSER/daemons.yml up"
alias cdcd="docker compose -f $CANDY_COMPOSER/daemons.yml down"
alias cdce="dceit composer-daemon-1 bash -l"
