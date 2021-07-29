fzf-search-wiki-widget() {
  fd --color always . '/Users/tim/certis/resources/wiki' | fzf --ansi
  zle reset-prompt;
  LBUFFER+=$result
}
zle     -N   fzf-search-wiki-widget
bindkey '^N^W' fzf-search-wiki-widget

fzf-search-dotfiles-widget() {
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

fzf-rg-widget(){
  # INITIAL_QUERY=""
  # RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  # FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
  #   fzf
  #   --bind "change:reload:$RG_PREFIX {q} || true" \
  #   --ansi --disabled --query "$INITIAL_QUERY" \
  #   --height=50% --layout=reverse
  # local result=$(
  # rg --column --line-number --no-heading --color=always --smart-case  | fzf \
  # --bind "change:reload:$RG_PREFIX {q} || true" \
  # --ansi --disabled --query "$INITIAL_QUERY" \
  # --height=50% --layout=reverse

  # )
  INITIAL_QUERY=""
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "

  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf \
    --bind "change:reload:$RG_PREFIX {q} || true" \
    --ansi --disabled --query "$INITIAL_QUERY" \
    --height=50% --layout=reverse \
    --preview-window hidden

  zle reset-prompt;
}
zle     -N   fzf-rg-widget
bindkey '^N^T' fzf-rg-widget
