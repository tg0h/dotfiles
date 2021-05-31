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
  rsync -avP --delete ~/certis /Volumes/joopyo/tim
  rsync -avP --delete ~/config /Volumes/joopyo/tim
  rsync -avP --delete ~/dotfiles /Volumes/joopyo/tim
  rsync -avP --delete ~/dev /Volumes/joopyo/tim
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
  # dependencies
  # brew install expect
  # env should contain nas_ssh_password

  expect ~/dotfiles/scripts/nas/nass.zsh
}
# NAS WAKUP/SLEEP FUNCTIONS -----------------------------------------------
