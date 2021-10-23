alias rc="redis-cli"
alias rcg="redis-cli GET" 
alias rcs="redis-cli SET" 
alias rcd="redis-cli DEL" 
alias rce="redis-cli EXPIRE"
alias rct="redis-cli TTL"
alias rcjs="redis-cli JSON.SET"
alias rcjg="redis-cli JSON.GET"

alias rcfa="redis-cli FLUSHALL"

alias rcka="redis-cli keys '*'"

function rcf(){
  # flush redis
  redis-cli flushall
}
