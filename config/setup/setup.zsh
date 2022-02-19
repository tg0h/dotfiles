# copy dotfiles from ssd to local
cp /Volumes/penwhel/dotfiles ~

# get brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install core brew packages
/opt/homebrew/bin/brew bundle --file ~/dotfiles/config/homebrew/brewfile

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

# do not use homebrew as it installs zinit to /opt/homebrew
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# install python
source ~/dotfiles/config/setup/setup-py.zsh

# install dotfiles
/opt/homebrew/bin/dotbot -c ~/dotfiles/install.conf.yaml
