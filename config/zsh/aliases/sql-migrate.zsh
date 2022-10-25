#TODO: ae does not work because sql-migrate filename has a dash in it ?

alias sms='sql-migrate status -config=dbconfig-local.yml'

alias smr='sql-migrate redo -config=dbconfig-local.yml'
alias smrd='sql-migrate redo -dryrun -config=dbconfig-local.yml'

alias smu='sql-migrate up -config=dbconfig-local.yml'
alias smud='sql-migrate up -dryrun -config=dbconfig-local.yml'

alias smd='sql-migrate down -config=dbconfig-local.yml -limit'
alias smdd='sql-migrate down -dryrun -config=dbconfig-local.yml -limit'
