# cred stash
alias clc="~/src/candy/old/candymold/tools/list-credentials.js"
alias cgc="~/src/candy/old/candymold/tools/get-credential.js"

# cognito
alias cclud="cclu dev | fzf -q 'timothyg'" # list users
alias cclus="cclu staging | fzf -q 'timothyg'" # list users
alias cccud="cccu -s dev" # create users
alias cccus="cccu -s staging -c"

alias ccdud="ccdu -s dev" # delete users
alias ccsud="ccdu -s staging"

# rc main environment
alias cedl="ced -l" # point to local db
alias ceds="ced -s" # point to staging db
alias cefl="cef -l" # turn off mocking
alias cefm="cef -m" # turn on mocking
