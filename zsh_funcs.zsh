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
  rsync -avP --delete ~/certis /Volumes/joopyo/tim
  rsync -avP --delete ~/config /Volumes/joopyo/tim
  rsync -avP --delete ~/dotfiles /Volumes/joopyo/tim
  rsync -avP --delete ~/dev /Volumes/joopyo/tim
}

function gn(){
  # set now to YYYY-MM-DDTHHMM - use iso 8601 format
  #see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html for docs on zmv
  now=$(date +%Y-%m-%dT%H%M)

# # -C forces cp, ln or mv
# zmv -C '*' './$f-$now'
}

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
