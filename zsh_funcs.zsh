# rg shortcuts
function rgs(){ rg $1 --sortr created }

function ffm() {
  ffmpeg -i $1 -vcodec libx265 -crf 28 "$1"-out.mp4
}


function gn(){
# set now to YYYY-MM-DD_THHMM
#see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html for docs on zmv
now=$(date +%Y-%m-%d_T%H%M)

# # -C forces cp, ln or mv
# zmv -C '*' './$f-$now'
}
