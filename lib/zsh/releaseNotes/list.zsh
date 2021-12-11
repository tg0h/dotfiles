# TODO: open parts of a file - eg open the officer section of the release notes
function _rnOpen() {
  # open release notes in release notes dir
  local filter releaseNotes open edit

   while getopts 'aoue' opt; do
    case "$opt" in
      a) filter='relx.*sprint.*sg';;
      o) filter='relx.*sprint.*optimax';;
      u) filter='relx.*sprint.*au';;
      e) edit="nvim";;
    esac
  done
  shift $(($OPTIND - 1))
 
  # ls $RELEASE_NOTES_DIR
  # let file=$(fd 'relx.*optimax' $RELEASE_NOTES_DIR)
  releaseNotes=$(fd "$filter" $RELEASE_NOTES_DIR | sort | tail -n 1)

  open=${edit:-bat}

  eval "$open '$releaseNotes'"
}

function ms() {
  # view argus sg release notes
  _rnOpen -a
}

function mse() {
  # view argus sg release notes
  _rnOpen -a -e
}

function mo() {
  # view argus optimax release notes
  _rnOpen -o
}

function moe() {
  # view argus optimax release notes
  _rnOpen -o -e
}

function ma() {
  # view argus au release notes
  _rnOpen -u
}

function mae() {
  # view argus au release notes
  _rnOpen -u -e
}
