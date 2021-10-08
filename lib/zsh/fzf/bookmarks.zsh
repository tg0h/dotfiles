_fzf-sb-getDirs(){
  # remove # comments and empty lines
  cat $1 | sed 's/#.*//g' | sed '/^\s*$/d'
}

function _fzf-sb-showDirs(){
    local bookmarks="$HOME/.config/bookmarks/bookmarks.config"

    local dirlist=$(_fzf-sb-getDirs $bookmarks)

    # echo -e "$system_wide_filelist\n$user_filelist" | sed '/^\s*$/d'
    echo -e "$dirlist" | sed '/^\s*$/d'
}

# Ensure precmds are run after cd
# https://github.com/junegunn/fzf/blob/f79b1f71b86651fe5656eab1c360781e19e97826/shell/key-bindings.zsh#L70-L77
_fzf-redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N _fzf-redraw-prompt

function fzf-search-bookmarks-widget(){
  local dest_dir=$(_fzf-sb-showDirs | fzf --preview-window hidden --height 100)

   if [[ $dest_dir != '' ]]; then
      cd "$dest_dir"
   fi
  # https://stackoverflow.com/questions/61075356/zle-reset-prompt-not-cleaning-the-prompt
  ##redraw the prompt so that it shows the correct directory
  zle _fzf-redraw-prompt
  # local precmd
  # for precmd in $precmd_functions; do
  #     $precmd
  # done
  # zle reset-prompt
}

zle     -N   fzf-search-bookmarks-widget
bindkey '^N^M' fzf-search-bookmarks-widget
