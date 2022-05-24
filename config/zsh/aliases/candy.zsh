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

# mock
alias mo="bat ./packages/frontend/.env.development* ./packages/api/api/.env.development*"
alias mof="echo 'NEXT_PUBLIC_API_MOCKING=false' > ./packages/frontend/.env.development.local"
alias moe="echo 'NEXT_PUBLIC_API_MOCKING=enabled' > ./packages/frontend/.env.development.local"
