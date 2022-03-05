# https://github.com/marlonrichert/zsh-autocomplete/blob/main/.zshrc# make zsh-autocomplete stay silent until 3 chars have been typed

# Wait this many seconds for typing to stop, before showing completions.
# zstyle ':autocomplete:*' min-delay 0.1  # float

zstyle ':autocomplete:*' min-input 2  # number of characters (integer)

#space does history expansion, does not do spelling correction
# zstyle ':autocomplete:space:*' magic expand-history

# If there are fewer than this many lines below the prompt, move the prompt up
# to make room for showing this many lines of completions (approximately).
# zstyle ':autocomplete:*' list-lines 16

#always show groups
# zstyle ':autocomplete:*' groups always

#turn off frecent-dirs
#zstyle ':autocomplete:*' frecent-dirs off

#tab starts menu selection instead of completing the closest match
# zstyle ':autocomplete:tab:*' completion insert
#zstyle ':autocomplete:tab:*' completion fzf
#

# zstyle ':autocomplete:list-choices:*' max-lines 5 #length of autocompletion list
