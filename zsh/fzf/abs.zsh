export _fzf_absdir="$HOME/dev/working/abs/abs/"

_fzf_abs_getFunctions(){
  # get all functions and description in abs folder
  #
  # ASSUMPTIONS:
  # each function is defined as function <functionName> () { ...
  # following each function definition, a single line comment describes the function
  # functions end with a single solitary }
  #
  # EXAMPLE:
  # function hello () {
  # # this function does not do anything
  # echo hello world
  # }
  #
  # edge cases:
  # function names that reappear, eg absas absaso
  # function endings . what if there are curly braces inside the function?

  # rg
  # --field-context-separator - as we specify -A 1, we do do not want fzf to 
  # prefix the context lines with a -
  #
  # -e 'function\s+(?P<fname>\w+)'
  # the regex searches for function, whitespace, and then uses a named capturing
  # group of a word character
  #
  # -r - replace matching output with the named capture group fname
  #
  # --no-context-separator
  # if you specify a context (-A, -B etc) and if there are mulitple matches, rg 
  # separates these matches with a --. Specify --no-context-separator to remove this
  #
  # gawk {$3="-";print} - replace 3rd column with - and print entire line

  # unable to use glob to specify working diretory glob is always relative to current working directory
  # https://github.com/BurntSushi/ripgrep/issues/973

  # use gsed -E because we do not want ( to be taken literally 
  # gsed use BRE by default. -E specifies that we uses ERE - extended regex
  # https://www.gnu.org/software/sed/manual/html_node/BRE-vs-ERE.html

    # --field-match-separator ' ' \

     # | gsed -E 's!(\s*)(#)!\2!'
     # remove any whitespace before the # 
     # s! ... ! ... !  - use an alternative delimiter, ! instead of /
  rg \
    --color always \
    --field-context-separator '' \
    --no-context-separator \
    --only-matching -e '^\s*function\s+(?P<fname>([^\s(]+))' -r '$fname' -A 1 \
    --field-match-separator ' ' \
    $_fzf_absdir \
    | gsed -E 's!(\s*)(#)!\2!' \
    | gsed "s!$_fzf_absdir!!" \
    | gsed 'N;s/\n/ /' \
    | gawk '{$3="-"; print}' 
    # gawk {$3 ..} is dangerous because it depends on previous code
}


_fzf_abs_displayFunction(){
  # given inputFile and inputFunc, use bat to display function body
  #
  # read file and func
  # output file funcStartLineNumber funcEndLineNumber

  local inputFile=$1
  local inputFunc=$2

  # local temp=$(  rg --only-matching \
  #    --field-match-separator ' ' \
  #    --multiline \
  #    -nH \
  #    -e '^function\s+'$inputFunc'\s*\(''(?s:.)*?(^\s*}$)' $inputFile \
  #  )
  # echo this is temp: $temp

  # gsed -e '1b;$!d'
  # - print 1st and last line
  #
  # '<command> ; <second command>'
  # b - branch - usually works with a label, if no label specified, jus skip this line
  # 1b means for the first line, skip the rest of the script
  # $ is a line address it means the last line of the file
  # ! is command negation !d means don't delete (and therefore print for the rest of the lines)

  # search for function <functionName> 
  # head -n 2 - get the start of the function and the end of the function }
  # ignore the remaining }'s because they belong to other functions
  # rg
  # -n - show line numbers
  # -H - show filename
  # -e 'function[^(]*'$inputFunc'\W' -e "\s*}$" $inputFile \
  
     # --field-match-separator ' ' \
     # | choose 0 1 5 | read -r outFile funcStart funcEnd

  local file=$_fzf_absdir$inputFile 

  # ?s is rust regex syntax to specify that the dot also captures a \n
  # *? is non greedy
  # (?s:.)*?

  rg --only-matching \
     --multiline \
     -nH \
     -e '^function\s+'$inputFunc'\s*\(''(?s:.)*?(^\s*}$)' $file \
     | gsed '1b;$!d' | gsed 'N;s/\n/ /' \
     | rg '(?::)(\d+)(?::)' -or '$1' | join-lines | read -r funcStart funcEnd _
    # | choose 0 1 5 

  echo file: $file
  echo func: $inputFunc
  echo fstart: $funcStart
  echo fend: $funcEnd
  bat --color=always $file -r $funcStart:$funcEnd
}

function _fzf_abs_nvim_edit(){

  local file=$1
  local func=$2
  # echo file: $file
  # echo func: $func

  local line=$(rg '^function\s+'$func'\s*\(' $_fzf_absdir$file -n | choose -f ':' 0)
  # echo line: $line
  
  nvim $_fzf_absdir$file +$line -c 'normal! zz'
}



fzf-search-abs-function-widget(){
  # nvim
  # see man vim options
  # nvim +<number> <file> opens the file at the number
  # nvim -c 'normal! zz' executes the normal command, the ! ensures that no keymappings are used
  #
  # rg
  # --only-matching - only return whatever matches the regex, not the entire line
  # --field-match-separator - instead of : to delimit the filepath, line etc, use another delimiter
  # -e -use this regex pattern, specify mulitiple regex patterns to AND them
  #
  # gsed
  # this 'N;s/\n/ /' incantation somehow combines every pair of lines
  #
  # choose
  # this is a rust implementation of cut
  # brew install choose-rust
  #
  # fzf
  # --preview {number} - get the nth field that is fed to fzf
  #
  # zsh
  # reset the prompt and add the result to the buffer
  local absdir="/Users/tim/dev/working/abs/abs/"
  
# rg --type zsh \
#   --only-matching \
#   -n \
#   --field-match-separator ' ' \
#   $absdir \
#   -e 'function[^(]*' -e "\s*}$" | gsed 'N;s/\n/ /' | choose 0 1 5 3 | fzf --preview 'bat --color=always {1} -r{2}:{3}' \
#   --bind "ctrl-e:execute(nvim {1} +{2} -c 'normal! zz' < /dev/tty > /dev/tty 2>&1)" \
#   | choose 3 
  local result=$(
  _fzf_abs_getFunctions | fzf --ansi \
    --preview="_fzf_abs_displayFunction {1} {2}" \
    --bind "ctrl-e:execute(_fzf_abs_nvim_edit {1} {2} < /dev/tty > /dev/tty 2>&1)"
)
zle reset-prompt;
LBUFFER+=$result
}

zle     -N   fzf-search-abs-function-widget  
bindkey '^H^S' fzf-search-abs-function-widget
