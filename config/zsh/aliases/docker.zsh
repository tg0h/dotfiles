################################################### Compose
alias dk='docker compose'
alias dku='docker compose up'
alias dkd='docker compose down'
alias dkud='docker compose up -d'
alias dkl='docker compose ls'
alias dkla='docker compose ls -a'
alias dkp='docker compose ps'
alias dkg='docker compose logs'
alias dkgf='docker compose logs --follow'

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

## TOP
alias dct='docker container top'
## STATS
alias dcst='docker container stats'

## LIST
# alias dcl='docker container ls'
alias dcll="docker container ls | rg -v 'dkr.ecr.ap-southeast-1.amazonaws.com' | rg -v 'composer'"
alias dcla='dcl -a'
alias dclaf='dcl -af' # exclude candy containers
alias dclaa="docker container ls -a | rg -v 'dkr.ecr.ap-southeast-1.amazonaws.com' | rg -v 'composer'"

## REMOVE
alias dcm='docker container rm '
alias dcmf='docker container rm -f'
alias dcma='docker container rm $(docker container ls -aq)'

## RUN
alias dcr='docker container run '
alias dcrit='docker container run -it'
alias dcrd='docker container run -d'
alias dcrdn='docker container run -d --name'

## START
alias dcs='docker container start'
alias dcsa='docker container start --attach --interactive'


## STOP
alias dcp='docker container stop' # sigint
alias dck='docker container kill' # sigkill


################################################### Images
alias dp='docker pull'
alias di='docker image'
alias dih='docker image history'
alias dii='docker image inspect'

alias dit='docker image tag'
alias dip='docker image push'

alias dir='docker image rm'

alias dib='docker image build'

alias dil='docker image ls'
alias dill="docker image ls | rg -v '^2.*'"

################################################### Network
alias dn='docker network'
alias dnc='docker network create'
alias dnr='docker network rm'
alias dno='docker network connect'
alias dnd='docker network disconnect'
alias dnl='docker network ls'
alias dni='docker network inspect'

################################################### Volume
alias dv='docker volume'
alias dvl='docker volume ls'
alias dvi='docker volume inspect'
alias dvr='docker volume rm'

################################################### Swarm
alias ds='docker service'
alias dsl='docker service ls'
alias dsp='docker service ps'
alias dsu='docker service update'
alias dsr='docker service rm'
alias dss='docker service scale'
