source $HOME/scripts/standard-funcs.sh

lookup() {
  ## default field numbers may be changed by command-line options
  key=1 ## field to use as the key
  val=2 ## field containing desired value ## use default field separator command-line options
  F=
  ## parse
  while getopts k:f:v: opt; do
    case $opt in
    f) F=$OPTARG ;;
    k) key=$OPTARG ;;
    v) val=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))
  str=$1 ## string to look up
  shift  ## remove look-up string from positional parameters
  ## if $F is empty, the field separator is not changed
  awk ${F:+-F "$F"} '$key == str { print $val }
  ' key=$key val=$val str="$str" "$@" #pass variables to awk from command line, eg $key becomes $1 which means awk looks for the 1st column

}

# eg load_db test.csv
# echo db[1]
load_db() {
  local IFS=$NL    ## Set IFS locally to a newline
  local shdb=$1    ## The first positional parameter is the file
  db=($(<"$shdb")) ## Slurp!

  # # this version ignores lines starting with #
  # local NB=${NB:-#}                      ## NB contains the comment character
  # db=($(grep -v "^[ $TAB]*$NB" "$shdb")) ## Slurp!
}

split_record() {
  local IFS=${DELIM:- $TAB} ## if DELIM not set, uses space and TAB
  local opts=$-             ## save shell option flags
  set -f                    ## disable pathname globbing
  record_vals=($*)          ## store arguments in array

  ## reset globbing only if it was originally set
  case $opts in
  *f*) ;;
  *) set +f ;;
  esac
}

csv_split() {
  csv_vnum=1              ## field number - zsh indexes start with 1
  csv_record=${1%"${CR}"} ## remove carriage return, if any
  unset record_vals       ## we need a pristine (global) array

  ## remove each field from the record and store in record_vals[]
  ## when all the records are stored, $csv_record will be empty
  while [ -n "$csv_record" ]; do
    case $csv_record in
    ## if $csv_record starts with a quotation mark,
    ## extract up to '",' or end of record
    \"*)
      csv_right=${csv_record#*\",}
      csv_value=${csv_record%%\",*}
      record_vals[$csv_vnum]=${csv_value#\"}
      ;;
    ## otherwise extract to the next comma
    *)
      record_vals[$csv_vnum]=${csv_record%%,*}
      csv_right=${csv_record#*,}
      ;;
    esac

    csv_record=${csv_right} ## the remains of the record

    ## If what remains is the same as the record before the previous
    ## field was extracted, it is the last field, so store it and exit
    ## the loop
    if [ "$csv_record" = "$csv_last" ]; then
      csv_record=${csv_record#\"}
      record_vals[$csv_vnum]=${csv_record%\"}
      break
    fi
    csv_last=$csv_record
    csv_vnum=$(($csv_vnum + 1))
  done
}

_put_record() {
  local NULL=
  local IFS=${DELIM:-$TAB}
  case $1 in
  -n*)
    NULL=${1#-n} ## no space after the option letter
    shift
    ;;
  -n)
    NULL=$2 ## space after the option letter
    shift 2
    ;;
  *)
    _PUT_RECORD="$*"
    return
    ;;
  esac
  _PUT_RECORD=$(
    for field in "$@"; do
      printf "%s${DELIM:-$TAB}" "${field:-$NULL}"
    done
  )
}

put_record() {
  _put_record "$@" && printf "%s\n" "$_PUT_RECORD"
}

_put_csv() {
  for field in "$@"; do ## loop through the fields (on command line)
    case $field in

    # what does this mean?  # *[!0-9.-]*)
    # * matches zero or more characters
    # [0-9.-] matches any digit, a . or a -
    # [!0-9.-] matches NOT (any digit, a . or a -) (only once)
    # * matches zero or more characters
    # note that [!0-9.-] matches only a single char, eg a but does not match aa
    # therefore we need asterisks

    ## If field contains non-numerics, enclose in quotes
    *[!0-9.-]*)
      _PUT_CSV=${_PUT_CSV:+$_PUT_CSV,}\"$field\"
      ;;
    *)
      _PUT_CSV=${_PUT_CSV:+$_PUT_CSV,}$field
      ;;
    esac
  done
  _PUT_CSV=${_PUT_CSV%,} ## remove trailing comma
}

put_csv() {
  _put_csv "$@" && printf "%s\n" "$_PUT_CSV"
}
