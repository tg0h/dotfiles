# TODO: preview node script
function fzf-npm-search-widget() {
  # search for npm commands in package.json
  local script
  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}

zle     -N   fzf-npm-search-widget
bindkey '^N^N' fzf-npm-search-widget
