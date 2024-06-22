alias y.="yarn workspace"
alias y,="yarn build"
alias y,.="LOG_LEVEL=silent yarn test-all"
alias y,.p="LOG_LEVEL=silent yarn test-all -nf"
alias y,.cs="LOG_LEVEL=silent yarn workspace @rc-main/common-services test"
alias y,.d="LOG_LEVEL=silent yarn workspace @rc-main/daemons test"
alias y,.fa="LOG_LEVEL=silent yarn workspace @rc-main/folp-api test"
alias y,.a="LOG_LEVEL=silent yarn workspace @rc-main/api test"
alias y,.ra="LOG_LEVEL=silent yarn workspace @rc-main/referralcorner-api test"

alias yi="yarn install"
alias ynb="NODE_OPTIONS=--openssl-legacy-provider yarn next build"

alias yy="yarn why"

alias yc="yarn config"
alias ycg="yarn config get"
alias ycs="yarn config set"

alias kk="killport 3001"
alias ys="killport 3001 && NODE_OPTIONS=--openssl-legacy-provider yarn start"
alias ysp="yarn start | pino-pretty"
alias ysf="yarn start-frontend"
alias ysa="yarn start-api"
# referralcorner-api
alias ysar="yarn start-api-referralcorner"
# embedded app
alias ysm="yarn start-embedded-app"
# wonka
alias ysfw="yarn start-frontend-wonka"
alias ysaw="killport 3001 && NODE_OPTIONS=--openssl-legacy-provider yarn start-api-wonka"
alias ysawp="yarn start-api-wonka | pino-pretty"
alias ysawps="LOG_LEVEL=silent yarn start-api-wonka | pino-pretty"
# daemon
alias ysd="yarn start-daemon"
alias ysdp="yarn start-daemon | pino-pretty"
alias ysds="LOG_LEVEL=silent yarn start-daemon"
# external-api
alias ysx="yarn workspace @rc-main/external-api start"

alias yw="yarn workspaces"
# alias ywl="yarn workspaces list"

# alias yp="yarn workspace @rc-main/ui-lib storybook"
alias yb="yarn workspaces foreach -v run build"

alias yp="yarn plugin list"
