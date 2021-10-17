# TODO: show local timezone for ggp command
function _setGitlabProj() {
  # export the command so that processes (eg app center cli commands) forked from
  # your terminal session inherit the GITLAB_PROJECT_ID variable
  case $1 in
    a) export GITLAB_PROJECT_ID=80
      echo Argus Kotlin
      ;;
    f) export GITLAB_PROJECT_ID=202
      echo Argus Flutter
      ;;
    o) export GITLAB_PROJECT_ID=229
      echo Optimax Android
      ;;
    oc) export GITLAB_PROJECT_ID=231
      echo Optimax CC
      ;;
    c) export GITLAB_PROJECT_ID=118
      echo Argus CC
      ;;
    t) export GITLAB_PROJECT_ID=223
      echo My Gitlab Test Project
      ;;
  esac
}

function gsp () {
  # gitlab switch profile
  # a - argus kotlin
  # f - argus flutter
  # o - optimax
  # c - cc
  # oc - optimax cc
  # t - argus cc test

  if [[ -z "$1" ]]
  then
    [[ $GITLAB_PROJECT_ID == 80 ]] && echo Argus Android
    [[ $GITLAB_PROJECT_ID == 202 ]] && echo Argus Flutter
    [[ $GITLAB_PROJECT_ID == 118 ]] && echo Argus CC
    [[ $GITLAB_PROJECT_ID == 223 ]] && echo My Gitlab Test Project
    [[ $GITLAB_PROJECT_ID == 229 ]] && echo Optimax Android
    [[ $GITLAB_PROJECT_ID == 231 ]] && echo Optimax CC
    return
  fi

  _setGitlabProj $1
}



# function ggddd(){
#   # read the function def into a variable
#   local FUNCS=$(functions ggd)

#   # xargs is unable to see the zsh function
#   # use zsh -c as a messy workaround
#   ggdd $1 | xargs -I{} zsh -c "eval $FUNCS; ggd {}"
# }
