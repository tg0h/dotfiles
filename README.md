# My cli setup

## Motivation

- prefer to use the command line and vim
- keep my functions and aliases accessible
- design keymaps that are consistent across apps. Eg, <modifier> g goes to previous tab/window in kitty/vim/yabai
- prefer shortcuts on the home row

## Folder Structure

- use the xdg folder system
  - config, cache, data, state
    - store configuration for packages
    - config/zsh
      - store aliases, global aliases
  - ~/.local/lib
    - store my zsh functions
  - ~/.local/bin
    - store my scripts

## Shell

- zsh
  - plugin management
    - zinit to lazy load plugins
  - faster startup
    - autoload functions for faster startup

## Workflow

- keyboard
  - ergodox
- text editor
  - neovim
- terminal
  - kitty tabs and panes
- window management
  - yabai

## Features

- dir switcher [here](/config/tg/dir-switcher/README.md) - define keymaps to switch to directories
- command runner - search for my functions and aliases with fzf [here](/lib/zsh/fzf/home-functions)
- dotfile management via dotbot
- macos package management via brewfile
- scratch pad
  - use entr to view results after saving

## Commits

- Conventional Commit
  - use lazygit custom command to quickly commit with conventional commit message

## Secrets

- zshenv, env
- git clean and smudge [here](bin/git-clean-smudge-filter)
  - .gitattributes
  - config file in yml with <secret> to <redactText> mapping
- password store to generate otps
- gpg key for public key and encryption

## Backup

- time machine
- rsync

## Tools

- fuzzy searching
  - [fzf](https://github.com/junegunn/fzf)
- searching - replace find and grep
  - [fd](https://github.com/sharkdp/fd)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
- git
  - [lazygit]
- view log files
  - [lnav]
- slice, dice, get stats
  - [angle grinder]
- json
  - jq
- entr

## Inspiration

- allaman - https://github.com/Allaman/dotfiles
- elijah manor - https://elijahmanor.com/blog/neovim-tmux
- primeagen

## todo

- fuzzy finding
  - add frecency to fuzzy finding
  - make function finding more granular
  - add display order
  - reload function or config from fuzzy finder
- add archive function
- how to manage sym links to eg work function repo
- how to manage env variables and display state on cli - similar to an aws global profile but for any of my functions
- better kitty tab bar
- better kitty tooling
  - scrollback buffer
