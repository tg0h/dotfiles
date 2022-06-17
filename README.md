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
  - ~/.local/lib
    - store my zsh functions
  - ~/.local/bin
    - store my scripts

## Shell

- zsh
  - plugin management
    - zinit
  - faster startup
    - autoload functions for faster startup

## Workflow

- text editor
  - neovim
- terminal
  - kitty tabs and panes
- window management
  - yabai

## Features

- dir switcher [here](/config/tg/dir-switcher/README.md) - define keymaps to switch to directories
- command palette - search for my functions and aliases with fzf [here](/lib/zsh/fzf/home-functions)
- dotfile management via dotbot
- macos package management via brewfile

## Commits

- Conventional Commit
  - use lazygit custom command to quickly commit with conventional commit message

## Secrets

- zshenv, env
- git clean and smudge

## Backup

- time machine
- rsync

## Tools

- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [lazygit]

## Inspiration
