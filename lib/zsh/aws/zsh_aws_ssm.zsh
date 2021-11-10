function ssmg(){
  # get parameters by path
  # provide the path first, run ssml to see what paths are available
  # use jq -L option to provide the path to my custom jq module
  aws ssm get-parameters-by-path --path "/$1" --recursive --with-decryption | jq -L "~/.config/jq" -r 'include "colour"; .Parameters[] | .Name + " = " + colour(.Value; "green")'
  # aws ssm get-parameters-by-path --path "/$1" --recursive --with-decryption | jq -L "~/.config/jq" -r 'include "module-colour"; .Parameters[] | .Name + " = " + colour_text("tim"; "red")'
}
function ssml(){
  # list available parameters
  # local array=$(aws ssm describe-parameters | jq -r '.Parameters[].Name' | tr '\n' ' ')
  aws ssm describe-parameters | jq -r '.Parameters[].Name'
  # echo ${=array} #split into multiple words
}
