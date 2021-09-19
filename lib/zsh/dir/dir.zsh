function lt1(){

    while getopts 'd' OPT; do
        case "$OPT" in
            d) dir=~/Downloads/;;
        esac
    done
    shift $(($OPTIND - 1))

    # -t sort by latest first
    # -p add trailing / to directories
    # -d add full path to file name
    local latestFile=$dir$(ls -tp $dir | rg -v / | head -n1)
    cp $latestFile .
    echo copied $fg[green]$latestFile$reset_color here
}

alias uda='cd $XDl_CACHE_HOME'
alias udt='cd $XDG_DATA_HOME'
alias uds='cd $XDG_STATE_HOME'
alias udb='cd ~/.local/bin'
alias udl='cd ~/.local/lib'

function udc(){
  # switch to my config folder
  cd $XDG_CONFIG_HOME
}
