# rg shortcuts
function rgs(){ rg $1 --sortr created }

function ffm() {
  ffmpeg -i $1 -vcodec libx265 -crf 28 "$1"-out.mp4
}


function fsync(){
  # --archive, -a            archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
  # --recursive, -r          recurse into directories
  # --links, -l              copy symlinks as symlinks
  # --perms, -p              preserve permissions
  # --times, -t              preserve modification times
  # --group, -g              preserve group
  # --owner, -o              preserve owner (super-user only)
  # -D                       same as --devices --specials
  # --devices                preserve device files (super-user only)
  # --specials               preserve special files

  # delete - remove files in target that do not belong in source
  # -v - verbose
  # -P - progress bar

  # Risk: what if i rysync wrongly and delete my home folder?
  rsync -avP --delete --exclude node_modules ~/certis ~/dotfiles ~/dev ~/src /Volumes/joopyo/tim
}

function nsync(){
  # nas sync
  # delete - remove files in target that do not belong in source
  # -v - verbose
  # -P - progress bar
  rsync -avP --delete /Volumes/joopyo/archive thoreau@tardis:~/backup
}

function tsync(){
  # start a time machine backup to tardis
  # run tmutil destination info to find the destination ids of the set up
  tmutil startbackup --destination 82F5CE2B-24BF-4518-9700-B60B6EE757BD

  # tmutil status gives you the status of the backup
  # running=0 means the backup is done
}

function gn(){
  # set now to YYYY-MM-DDTHHMM - use iso 8601 format
  #see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html for docs on zmv
  now=$(date +%Y-%m-%dT%H%M)

# # -C forces cp, ln or mv
# zmv -C '*' './$f-$now'
}

# NAS WAKUP/SLEEP FUNCTIONS -----------------------------------------------
function nasw(){
  # nas wakeup
  # dependencies:
  #   brew install wakeonlan
  #   find the mac address of your nas
  #   of course, you need to enable wake on lan in your nas

  wakeonlan 00:11:32:6F:07:B6
}

function nass(){
  # nas shutdown
  # dependencies
  # brew install expect
  # env should contain nas_ssh_password

  expect $HOME/.local/bin/nas/nass.zsh

}
# NAS WAKUP/SLEEP FUNCTIONS -----------------------------------------------

function displaytime {
  # get seconds, convert to days, hours and minutes
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}

function so (){
  # source a function, source the previous function if none provided
  # examples:
  # so <functionName>
  # so - if no function name provided, use the previously sourced function
  # so -n - source the previously edited file in nvim

  local nvimCacheOpt=""
  while getopts 'n' opt; do
    case "$opt" in
      n) nvimCacheOpt=true;;
    esac
  done
  shift $(($OPTIND - 1))


  local file=$1
  local cache=/tmp/_so_cache
  local nvim_cache=/tmp/_nvim_cache

  # if no argument provided
  if [[ -n $file ]]; then
    source $file
    echo "$fg[cyan] $file sourced $reset_color"

    # store filepath in cache
    local fullpath=$(realpath $file)
    echo "$fg[cyan] storing in so cache ... $reset_color"
    echo $fullpath > $cache
    echo "$fg[cyan] stored $file in so cache ... $reset_color"
  elif [[ -n $nvimCacheOpt ]]; then
    local nvimfile=$(cat /tmp/_nvim_cache | head -n 1 | choose 0)
    echo "$fg[green] sourcing from nvim cache ... $reset_color"
    source $nvimfile
    echo "$fg[green] sourced $nvimfile $reset_color"

    echo $nvimfile > $cache
    echo "$fg[cyan] stored $nvimfile in so cache ... $reset_color"
  else
    echo "$fg[yellow] sourcing from so cache ... $reset_color"
    local cachedFile
    cachedFile=$(cat $cache | head -n 1)
    echo "$fg[yellow] sourced $cachedFile $reset_color"
    if [[ -n cachedFile ]]; then
      source $cachedFile
    else
      echo no function found in cache
    fi

  fi
}
