#!/bin/zsh

tt(){
  while getopts 'p:' opt; do
    case "$opt" in
      p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  echo args is $@

  shift

  echo args is $@

  for ticket in "$@"; do
    echo $ticket
  done
}

