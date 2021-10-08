function lt1(){
  # copy latest download to current folder

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


function ud(){
  # switch to my config folder
  # ud <searchDir> <searchDepth)
  # eg ud ~/.locall/bin 2
  # udc - config
  # uda - cache
  # udt - data
  # uds - state
  # udb - bin
  # udl - lib
  local changeToDir
  local searchDir=${1:-$XDG_CONFIG_HOME} # var expansion with default - get the $1 arg, if not found, default to $XDG_CONFIG_HOME
  local searchDepth=${2:-1} # var expansion with default - get the $1 arg, if not found, default to $XDG_CONFIG_HOME
  # fd --follow - follow symlink
  # TODO: exa does not show the contents for the symlink if you do not specify a trailing /
  changeToDir=$(fd . $searchDir --hidden --follow --color always --max-depth $searchDepth | fzf +m --preview='[[ $(file --mime {}) =~ inode/directory ]] && exa --tree --long --icons --git --color always --octal-permissions --sort created --reverse --level 3 {}/ || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300') &&
  cd "$changeToDir"
}
function udc(){ ud $XDG_CONFIG_HOME }
function uda(){ ud $XDG_CACHE_HOME }
function udt(){ ud $XDG_DATA_HOME }
function uds(){ ud $XDG_STATE_HOME }
function udb(){ ud ~/.local/bin }
function udl(){ ud ~/.local/lib 2}
