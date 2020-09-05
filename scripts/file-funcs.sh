# date-file [OPTIONS] FILE ...
# By default, date-file adds a date in the format .YYYY-MM-DD to the end of each filename supplied on the command line. If the filename is -, filenames are read from the standard input. The options can change everything from the format of the date to the location of the file’s final resting place.
# • -c: Create a new, empty file (because some logging utilities write to a log file only when it already exists).
# • -d DIR: Move file to directory DIR. If the directory doesn’t exist, date-file will try to create it. If it is unsuccessful, it will exit with an error.
# • -D: Include time and date in the new filename by using the format string _%Y-%m- %d_%H.%M.%S.
# • -f FMT: Use FMT as the date format string instead of .%Y-%m%d.
# • -h CMD: Execute the command CMD after moving the file. If a program keeps its log file open, it could continue to write to the old file. Sending the HUP signal causes it to reload its configuration files and close any files it has open. On my Mandrakelinux system, for example, logrotate uses /usr/bin/killall -HUP syslogd to tell syslogd to close the old log file and use the new one.
# • -s: Insert the date before the final suffix.
# • -S SUFF: Insert the date before the suffix, SUFF, if it matches the end of the filename.
# • -v: Verbose mode; print the old and new names for each file.
# • -z: Compress the file with gzip.
# • -Z CMD: Compress the file with CMD, (bzip2, for example).

## The change of name is done by the mv_file function. ## USAGE: mv_file PATH/TO/FILE
mv_file() {
  ## if the file in $1 does not exist, return an error
  [ -f "$1" ] || return 5
  if [ $pre_suffix -eq 0 ]; then
    echo add to end of file
    ## By default, date-file adds the date to the end of the name
    newname=$1$DATE
  else
    echo pre suffix is 1
    ## If pre_suffix has been set to anything other than 0,
    ## the date is inserted before the suffix
    #see zsh parameter expansion http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion
    echo this is suffix $suffix
    echo this is 1 $1
    basename=${1%$suffix} ## get filename without suffix, % removes the substring from the end of the string
    echo this is basename $basename
    postfix=${1#$basename} ## get the suffix alone
    # postfix=${1:t:e} ## get the suffix alone - this is a zsh trick :(
    echo this is postfix $postfix
    newname=$basename$DATE$postfix ## place the date between them
    echo this is newname $newname
  fi
  ## If a destination directory has been given, the new name is
  ## the destination directory followed by a slash and the
  ## filename without any old path
  [ -n "$dest" ] && newname=$dest/${newname##*/}
  ## If in verbose mode, print the old and new filenames
  if [ $verbose -ge 1 ]; then
    printf "\"%-25s -> \"%s\"\n" "$1\"" "$newname" >&2
  fi
  ## Move the file to its new name or location
  mv "$1" "$newname"

  ## If the option is selected, create a new, empty file
  ## in place of the old one
  [ $create -eq 1 ] && touch "$1"

  ## If the application that writes to the log file keeps the ## file open, send it a signal with the script in $hup.
  [ -n "$hup" ] && eval "$hup"

  ## Compress if selected
  [ -n "$gzip" ] && $gzip "$newname"
  return 0
}

date-file() {
  echo hello

  ## All these defaults may be overridden by command-line options
  pre_suffix=0   ## do not place DATE before suffix
  suffix=".*"    ## used if pre_suffix is set to 1
  dfmt=_%Y-%m-%d ## default date format: _YYYY-MM-DD
  verbose=0      ## verbose mode off
  dest=          ## destination directory
  create=0       ## do not re-create (empty) file
  gzip=          ## do not use compression
  hup=           ## command to interrupt program writing to file

  ## Parse command-line options
  opts=cd:Df:h:o:sS:vzZ:
  while getopts $opts opt; do
    case $opt in
    c) create=1 ;; ## Create new, empty file
    d)
      [ -d "$OPTARG" ] ||  ## Move files to different dir
        mkdir "$OPTARG" || ## create if necessary
        exit 5             ## return error if not possible
      dest=${OPTARG%/}
      ;;                          ## remove trailing slash
    D) dfmt=_%Y-%m-%d_%H.%M.%S ;; ## use time as well as date
    f) dfmt=$OPTARG ;;            ## use supplied date format
    h) hup=$OPTARG ;;             ## command to run after mv
    s) pre_suffix=1 ;;            ## place date before suffix
    S)
      suffix=$OPTARG ## place date before specified
      pre_suffix=1
      ;;                            ## suffix
    v) verbose=$(($verbose + 1)) ;; ## verbose mode
    z) gzip=gzip ;;                 ## compress file with gzip
    Z) gzip=$OPTARG ;;              ## compress file with supplied cmd
    *) exit 5 ;;                    ## exit on invalid option
    esac
  done

  shift $(($OPTIND - 1)) ## Remove options from command line

  ## Store the date in $DATE
  eval $(date "+DATE=$dfmt ")

  ## Loop through files on the command line
  for file; do
    case $file in
    -) ## If a $file is "-", read filenames from standard input
      while IFS= read -r file; do
        mv_file "$file"
      done
      ;;
    *) 
      echo helllllo
      mv_file "$file" ;;
    esac
  done
}
