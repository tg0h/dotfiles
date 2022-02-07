################################################### Containers
alias dc='docker container'

alias dca='docker container attach'

## EXEC
alias dce='docker container exec'
alias dceit='docker container exec -it'
alias dceh='docker container exec --help'

## LOGS
alias dcg='docker container logs'
alias dcgt='docker container logs --tail'

## INSPECT
alias dci='docker container inspect'

## PORT
alias dco='docker container port'


## LIST
alias dcl='docker container ls'
alias dcla='docker container ls -a'

## REMOVE
alias dcm='docker container rm '
alias dcma='docker container rm $(docker container ls -aq)'

## RUN
alias dcr='docker container run '
alias dcrit='docker container run -it'
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
