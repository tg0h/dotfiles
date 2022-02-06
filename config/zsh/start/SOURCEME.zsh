# source these files that are outside the $XDG_CONFIG_HOME/zsh directory
# this shortens my zshrc by a few lines
source $ZSH/oh-my-zsh.sh
source $XDG_CONFIG_HOME/zsh/p10k/p10k.zsh # p10k configuration
source $XDG_CONFIG_HOME/lf/icons

# the fzf key bindings and shell completions are here
source $XDG_CONFIG_HOME/fzf/fzf.zsh # source fzf after bindkey -v in zshrc so fzf shortcuts take precedence
