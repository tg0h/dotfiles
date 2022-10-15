# brewfile
alias bb='brew bundle --file ~/dotfiles/config/homebrew/brewfile'
alias bbs='nvim ~/dotfiles/config/homebrew/brewfile'
alias bbc='brew bundle --file ~/dotfiles/config/homebrew/brewfile --force cleanup'

# uninstall
alias bu='brew uninstall'

# services
alias bs='brew services'
alias bsl='brew services list'

alias bsr='brew services restart'
alias bsra='brew services restart --all'
alias bsry='brew services restart yabai'
alias bsrs='brew services restart skhd'

alias bss='brew services stop'
