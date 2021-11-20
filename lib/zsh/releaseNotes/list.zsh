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

function aa() {
  # view argus sg release notes
  _rnOpen -a
}

function aae() {
  # view argus sg release notes
  _rnOpen -a -e
}

function ao() {
  # view argus optimax release notes
  _rnOpen -o
}

function aoe() {
  # view argus optimax release notes
  _rnOpen -o -e
}

function at() {
  # view argus au release notes
  _rnOpen -u
}

function ate() {
  # view argus au release notes
  _rnOpen -u -e
}
