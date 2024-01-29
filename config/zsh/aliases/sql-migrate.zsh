#TODO: ae does not work because sql-migrate filename has a dash in it ?

alias sms='sql-migrate status -config=dbconfig.timg.yml'

alias smr='sql-migrate redo -config=dbconfig.timg.yml'
alias smrd='sql-migrate redo -dryrun -config=dbconfig.timg.yml'

alias smu='sql-migrate up -config=dbconfig.timg.yml'
alias smud='sql-migrate up -dryrun -config=dbconfig.timg.yml'

alias smd='sql-migrate down -config=dbconfig.timg.yml -limit'
alias smdd='sql-migrate down -dryrun -config=dbconfig.timg.yml -limit'
