. ~$HOME/scripts/standard-vars.sh

get_key() {
  [ -t 0 ] && { ## Check whether input is coming from a terminal
    [ -z "$_STTY" ] && {
      _STTY=$(stty -g) ## Store the current settings for later restoration }
    }

    ## By default, the minimum number of keys that needs to be entered is 1
    ## This can be changed by setting the dd_min variable
    ## If the TMOUT variable is set greater than 0, the time-out is set to
    ## $TMOUT seconds
    if [ ${TMOUT:--1} -ge 0 ]; then
      _TMOUT=$TMOUT
      stty -echo -icanon time $(($_TMOUT * 10)) min ${dd_min:-1}
    else
      stty -echo -icanon min ${dd_min:-1}
    fi
  }

  ## Read a key from the keyboard, using dd with a block size (bs) of 1.
  ## A period is appended, or command substitution will swallow a newline
  _KEY=$(
    dd bs=1 count=1 2>/dev/null
    echo .
  )
  _KEY=${_KEY%?} ## Remove the period

  ## If a variable has been given on the command line, assign the result to it
  [ -n "$1" ] &&
    ## Due to quoting, either ' or " needs special treatment; I chose '
    case $_KEY in
    "'") eval "$1=\"'\"" ;;
    *) eval "$1='$_KEY'" ;;
    esac
  [ -t 0 ] && stty "$_STTY" ## reset terminal
  [ -n "$_KEY" ]            ## Succeed if a key has been entered (not timed out)
}

_getline() {
  ## Check that the parameter given is a valid variable name
  case $2 in
  [!a-zA-Z_]* | *[!a-zA-Z0-9_]*) die 2 "Invalid variable name: $2" ;;
  *) var=${2:-_GETLINE} ;; esac

  ## If the variable name is "password" do not turn on echoing [ -t 0 ] && [ "$2" != "password" ] && stty echo
  case ${BASH_VERSION%%.*} in
  [2-9] | [1-9][0-9])
    read ${TMOUT:+-t$TMOUT} -ep "$1: " -- $var
    ;;
  *)
    printf "%s: " "$1" >&2
    IFS= read -r $var
    ;;
  esac
  [ -t 0 ] && stty -echo ## turn echoing back off
}

press_any_key() {
  printf "\r <PRESS ANY KEY> " get_key
  printf "\r \r"
  ## Display the message
  ## Get the keystroke
  ## Erase the message
}

menu1() {
  m1_items=$#            ## Number of commands (i.e., arguments)
  while :; do            ## Endless loop
    printf "%s " "$menu" ## Display menu
    get_key Q            ## Get user's choice
    case $Q in
    0 | q | "" | "$NL")
      printf "\n"
      break
      ;;           ## Break out
    [1-$m1_items]) ## Valid number
      printf "\n"
      (eval "\$$Q")        ## Execute command
      case $pause_after in ## Pause if set
      *?)
        press_any_key
        ;;
      esac
      ;;
    *)
      printf "\n\t\a%sInvalid entry: %s\n" "${progname:+$progname: }" "$Q"
      continue
      ;;
    esac
    [ -n "$_MENU1" ] && break ## If set, exit after one successful selection
  done
}

#The arguments to the script are passed using "$@" to arg; if there is an argument, it is stored in $_arg; if not, the user is prompted (with the value of $prompt) to enter an appropriate value.
arg() {
  case $1 in
  "")
    printf "%s? " "$prompt" >&2 ## Prompt for input
    stty echo                   ## Display characters entered
    read arg </dev/tty          ## Get user's input
    ;;
  *)
    arg="$*" ## Use existing arguments
    units=   ## For use with the conversion script, Chapter 5
    ;;
  esac
}

#The die function takes an error number and a message as arguments. The first argument is stored in $result, and the rest are printed to the standard error.
die() {
  result=$1
  shift
  printf "%s\n" "$*"
  exit $result >&2
}

_show_date() {
  oldIFS=$IFS ## Save old value of IFS
  IFS=" -./"  ## Allow splitting on hyphen, period, slash and space ## Re-split arguments
  set -- $*
  IFS=$oldIFS ## Restore old IFS

  ## If there are less than 3 arguments, use today's date
  [ $# -ne 3 ] && {
    date_vars ## Populate date variables (see the next function)
    _SHOW_DATE="$_DAY $MonthAbbrev $YEAR"
    return
  }
  case $DATE_FORMAT in
  dmy)
    _y=$3 ## day-month-year format
    _m=${2#0}
    _d=${1#0}
    ;;
  mdy)
    _y=$3 ## month-day-year format
    _m=${1#0}
    _d=${2#0}
    ;;
  *)
    _y=$1 ## most sensible format
    _m=${2#0}
    _d=${3#0}
    ;;
  esac

  ## Translate number of month into abbreviated name
  set Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
  eval _m=\${$_m}
  _SHOW_DATE="$_d $_m $_y"
}

date_vars() {
  eval $(date "$@" "+DATE=%Y-%m-%d YEAR=%Y
  MONTH=%m
  DAY=%d
  TIME=%H:%M:%S
  HOUR=%H
  MINUTE=%M
  SECOND=%S datestamp=%Y-%m-%d_%H.%M.%S DayOfWeek=%a
  DayOfYear=%j DayNum=%w MonthAbbrev=%b")

  ## Remove leading zeroes for use in arithmetic expressions _MONTH=${MONTH#0}
  _DAY=${DAY#0}
  _HOUR=${HOUR#0}
  _MINUTE=${MINUTE#0} _SECOND=${SECOND#0}

  ## Sometimes the variable, TODAY, is more appropriate in the context of a ## particular script, so it is created as a synonym for $DATE
  TODAY=$DATE

  export DATE YEAR MONTH DAY TODAY TIME HOUR MINUTE SECOND
  export datestamp MonthAbbrev DayOfWeek DayNum
}

is_num() {
  case $1 in
  *[!0-9]*) return 5 ;; ## Fail is any character is not a digit from 0 to 9
  esac
}

#The suffix, K, M, or G, is determined by the length of the number, and the number is divided by 1000, 1000000, or 1000000000 as required. The result is always a maximum of four characters.
_abbrev_num() {
  case ${#1} in
  1 | 2 | 3 | 4) _ABBREV_NUM=$1 ;;
  5 | 6) _ABBREV_NUM=$((($1 + 500) / 1000))K ;;
  7 | 8 | 9) _ABBREV_NUM=$((($1 + 500000) / 1000000))M ;; 10 | 11 | 12) _ABBREV_NUM=$((($1 + 500000000) / 1000000000))G ;; *) _ABBREV_NUM="HUGE" ;;
  esac
}

_commas() {
  _COMMAS=    ## Clear the variable for the result
  _DECPOINT=. ## Character for decimal point; adjust for other locales
  _TH_SEP=,   ## Character for separator; adjust for other locales
  case $1 in
  "$_DECPOINT"*)
    _COMMAS=$1 ## Number begins with dot; no action needed return
    ;;
  *"$_DECPOINT") ## Number ends with dot; store it in $c_decimal
    c_num=${1%"$_DECPOINT"}
    c_decimal=.
    ;;
  *"$_DECPOINT"*)
    c_num=${1%"$_DECPOINT"*} ## Separate integer and fraction
    c_decimal=$_DECPOINT${1#*"$_DECPOINT"}
    ;;
  *)
    c_num=$1 ## No dot, therefore no decimal
    c_decimal=
    ;;
  esac

  while :; do
    case $c_num in
    ## Three, two or one digits [left] in $num;
    ## add them to the front of _COMMAS and exit from loop
    ??? | ?? | ?)
      _COMMAS=${c_num}${_COMMAS:+"$_TH_SEP"$_COMMAS}
      break
      ;;
    *)                  ## More than three numbers in $num
      left=${c_num%???} ## All but the last three digits

      ## Prepend the last three digits and a comma
      _COMMAS=${c_num#${left}}${_COMMAS:+"$_TH_SEP"$_COMMAS}
      c_num=$left ## Remove last three digits
      ;;
    esac
  done
  ## Replace decimal fraction, if any
  _COMMAS=${_COMMAS}${c_decimal}
}

commas() {
  for n; do
    _commas "$n" && printf "%s\n" "$_COMMAS"
  done
}

pr1() {
  case $1 in
  -w) pr_w= ;;
  *) pr_w=-.${COLUMNS:-80} ;;
  esac
  printf "%${pr_w}s\n" "$@"
}

checkdirs() {
  checkdirs=0            ## Return status: success unless a check fails
  for dir; do            ## Loop through the directory on the command line
    [ -d "$dir" ] &&     ## Check for the directory
      continue ||        ## If it exists, proceed to the next one
      mkdir -p "$dir" || ## Attempt to create it
      checkdirs=1        ## Set error status if $dir couldn't be created
  done
  return $checkdirs ## Return error status
}

checkfiles() {
  checkdict=$1                     ## Directory must be first argument
  [ -d "$checkdict" ] || return 13 ## Fail if directory does not exist
  shift                            ## Remove dir from positional parameters
  for _CHECKFILE; do               ## Loop through files on command line
    [ -f "$checkdict/$checkfile" ] || return 5
  done
}

_zpad() {
  ZPAD=$1
  while [ ${#_ZPAD} -lt $2 ]; do
    _ZPAD=${3:-0}$_ZPAD
  done
}

zpad() {
  _zpad "$@" && printf "%s\n" "$_ZPAD"
}

#The trap command tells the shell to execute certain commands when a signal is received. If a trap is set on the EXIT signal, the specified commands will be executed whenever the script finishes, whether by a normal completion, and error, or by the user pressing Control+C. The cleanup function is designed for that purpose.
cleanup() {
  ## delete temporary directory and files
  [ -n "$tempfile_dir" ] && rm -rf "$tempfile_dir"
  ## Reset the terminal characteristics [ -t 0 ] && {
  [ -n "$_STTY" ] && stty $_STTY || stty sane }
  exit
}
trap cleanup EXIT ## Set trap to call cleanup on exit
