
# list logs
_ch(){
  # jq will not escape strings with --raw-output
  aws logs describe-log-groups | jq --raw-output '.logGroups[].logGroupName' | fzf
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-cloudwatch-helper() {
  local c
  for c in $@; do
    # LBUFFER refers to the text to the left of your cursor in the terminal
    # add your widget's result to the cursor position
    
    eval "fzf-c$c-widget() { local result=\$(_c$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    
    # -N - define a user defined zle widget
    # https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
    eval "zle -N fzf-c$c-widget"
    eval "bindkey '^h^$c' fzf-c$c-widget"
  done
}

bind-cloudwatch-helper h
unset -f bind-cloudwatch-helper
