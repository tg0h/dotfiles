# set up colored man pages
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
# man uses less to display the doc
# termcap (replaced by terminfo) describes the capabilities of the terminal
# the man application uses the less termcap env vars below to tell less how to colorize the doc

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
