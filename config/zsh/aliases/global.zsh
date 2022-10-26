# redirect stderr to null
alias -g no='2&>/dev/null'
alias -g Q='>/dev/null'

# regex for argus ticket key
alias -g A="'ARG-\d*'"

# alias -g h="--help"

alias -g B='| bat'
alias -g BR='| bat -r'

alias -g C='| choose'

alias -g F='| fzf --preview-window hidden'

alias -g H='| head -n 10'
alias -g T='| tail -n 10'

alias -g P="| tr -d '\n' | pbcopy" # remove newlines before putting in pbcopy

# docker
alias -g DJ="--format='{{json .}}'" # show fields in output for use in format table go template

# T registers
alias -g CT='cat /tmp/t'
alias -g ET='nvim /tmp/t'
alias -g T='> /tmp/t'
alias -g FT='/tmp/t'
alias -g CTT='cat /tmp/tt'
alias -g TT='> /tmp/tt'
alias -g ETT='nvim /tmp/tt'
alias -g FTT='/tmp/tt'

# alias -g G='| gron --colorize' # do not colorize if sending to a pipe, causes ungron to fail eg
alias -g G='| gron'
alias -g W='| wc -l'
alias -g J='| jq .'

# rg
alias -g R='| rg'
alias -g RA='| rg -A' # after
alias -g RB='| rg -B' # before
alias -g RV='| rg -v' # invert search
alias -g RO='| rg -o' # only matching

alias -g S='| sort'
alias -g SV='| sort -V'
alias -g SVK='| sort -V -k'
alias -g U='| sort | uniq'
alias -g X='| fx'
