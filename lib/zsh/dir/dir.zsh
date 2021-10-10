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
  # fzf preview and switch to folder
  # ud configure - show configuration
  # ud configure edit - edit configuration
  # examples:
  # ud <searchDir> <searchDepth)
  # eg ud ~/.local/bin 2
  local configFile=$XDG_CONFIG_HOME/zsh/dir/config.yml

  [[ $1 == "configure" ]] && [[ $2 != "edit" ]] && yq eval '.keymaps' $configFile --colors | fzf && return

  # prefer nvim over eu for clarity and unneeded dependency on eu alias
  [[ $1 == "configure" ]] && [[ $2 == "edit" ]] && nvim $configFile && return

  local changeToDir
  local searchDir=${1:-$XDG_CONFIG_HOME} # var expansion with default - get the $1 arg, if not found, default to $XDG_CONFIG_HOME
  local searchDepth=${2:-1} # var expansion with default - get the $1 arg, if not found, default to $XDG_CONFIG_HOME
  # fd --follow - follow symlink
  # TODO: exa does not show the contents for the symlink if you do not specify a trailing /

  # fd show --hidden ?
  local changeToTarget=$(fd . $searchDir --follow --color always --max-depth $searchDepth | fzf +m --preview='[[ $(file --mime {}) =~ inode/directory ]] &&
    exa --tree --long --icons --git --color always --sort modified --reverse --level '$searchDepth' --no-permissions --no-user --changed --git {}/ || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300') &&

  # change to directory if it is not null, needed if fzf does not return a dir, eg
  # if fzf cancels via ctrl c
  if [[ -n "$changeToTarget" ]]; then
    # if target is a file (check with -f), change to its dir instead
    [[ -f $changeToTarget ]] && changeToTarget=${changeToTarget%/*} # zsh variable expansion - min match pattern /* and remove from tail
    cd $changeToTarget
  fi
}

_udInitialize(){
  # read from the config.yml file and dynamically define the ud<key> functions
  # to fzf dir switch to the configured directories
  local configFile=$XDG_CONFIG_HOME/zsh/dir/config.yml
  local config=$(yq eval '.keymaps' $configFile --output-format json | jq --compact-output '.[]')
  # for row in $config; do
  # while read loop splits only on newlines, unlike for do read which splits on any whitespace
  while read row; do
    local bindkey=$(jq '.bindkey' <<< $row)
    local dir=$(jq '.dir' <<< $row)
    # https://github.com/stedolan/jq/issues/354#issuecomment-43147898
    # // is the jq alternative operator
    # empty is a jq builtin
    local options=$(jq '.options // empty' <<< $row)
    # no longer discoverable from my function finder
    eval "ud$bindkey() {ud $dir $options}"
  done <<< $config
}

_udInitialize
unset -f _udInitialize #remove the function

