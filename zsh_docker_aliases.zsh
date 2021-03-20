################################################### Containers
alias dc='docker container'

alias dca='docker container attach'

alias dce='docker container exec'

alias dcg='docker container logs'
alias dcgt='docker container logs --tail'

alias dci='docker container inspect'


## LIST
alias dcl='docker container ls'
alias dcla='docker container ls -a'

## REMOVE
alias dcm='docker container rm '
alias dcma='docker container rm $(docker container ls -aq)'

alias dcr='docker container run '
alias dcrd='docker container run -d'
alias dcrdn='docker container run -d --name'

## START
alias dcs='docker container start'


## STOP
alias dcp='docker container stop'


################################################### Images
alias di='docker image'

alias dir='docker image rm'

alias dil='docker image ls'

################################################### Network
alias dn='docker network'
