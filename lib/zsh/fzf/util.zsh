function fzf-search-dotfiles-widget() {
  # ^N^H to search my dotfiles
  
  # TODO: does not paste selection on command line nicely, unlike fzf ctrl t

  #include f - files and l - symlinks
  local FD_FILETYPE="--type f --type l"
  # --follow - follow symlinks
  # --hidden - include hidden files and directories
  local FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules"

  #do not show hidden files, since my files in dotfiles will not be hidden
  local result=$(
  fd . \
    --color always \
    --type f --type l \
    --follow \
    --exclude .git \
    --exclude node_modules \
    --exclude dotbot '/Users/tim/dotfiles' | fzf --ansi)

  # reset the prompt so that it is shown again
  zle reset-prompt;
  # add the fzf result to your existing buffer, if not, the result is shown above
  # your existing buffer
  LBUFFER+=$result
}

zle     -N   fzf-search-dotfiles-widget
bindkey '^N^H' fzf-search-dotfiles-widget

