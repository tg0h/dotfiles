/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

# do not use homebrew as it installs zinit to /opt/homebrew
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

pyenv install 3.8.12
pyenv global 3.8.12

python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install pyfunky

nvm install 16
nvm default 16
