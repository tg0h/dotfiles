pyenv install --skip-existing 3.8.12
pyenv global 3.8.12

# does this use the system python3 or the pyenv python3 when bootstrapping?
python3 -m pip install --user pipx
python3 -m pipx ensurepath
# pipx installs python applications for you to use. You do not want your applications to depend on your current python development environment version
pipx install pyfunky
pipx install urlscan
