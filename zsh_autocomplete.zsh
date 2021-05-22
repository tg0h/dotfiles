# make zsh-autocomplete stay silent until 3 chars have been typed
zstyle ':autocomplete:*' min-input 3  # number of characters (integer)

#space does history expansion, does not do spelling correction
zstyle ':autocomplete:space:*' magic expand-history

#always show groups
# zstyle ':autocomplete:*' groups always

#turn off frecent-dirs
#zstyle ':autocomplete:*' frecent-dirs off

#tab starts menu selection instead of completing the closest match
zstyle ':autocomplete:tab:*' completion insert
#zstyle ':autocomplete:tab:*' completion fzf
#

# zstyle ':autocomplete:list-choices:*' max-lines 5 #length of autocompletion list
