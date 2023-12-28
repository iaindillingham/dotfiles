#!/usr/bin/env bash

# bootstrap.sh
# ============
# Set up a macOS environment.
#
# shfmt --write --language-dialect bash --indent 4 bootstrap.sh
#
set -euo pipefail

BASE_DIR=${1:-$HOME}
CONFIG_DIR=$BASE_DIR/.config
DATA_DIR=$BASE_DIR/.local/share
HOMEBREW_PREFIX="$(brew --prefix)"

echo "BASE_DIR=${BASE_DIR}"
echo "CONFIG_DIR=${CONFIG_DIR}"
echo "DATA_DIR=${DATA_DIR}"
echo "HOMEBREW_PREFIX=${HOMEBREW_PREFIX}"
echo -e '\n'

echo 'Installing all dependencies from the Brewfile'
brew bundle install --no-lock --file Brewfile
echo -e '\n'

echo 'Creating directories'
mkdir -pv "${CONFIG_DIR}"
mkdir -pv "${CONFIG_DIR}"/direnv
mkdir -pv "${CONFIG_DIR}"/git
mkdir -pv "${CONFIG_DIR}"/nvim
mkdir -pv "${CONFIG_DIR}"/tig
mkdir -pv "${CONFIG_DIR}"/tmux
mkdir -pv "${BASE_DIR}"/.pyenv
mkdir -pv "${BASE_DIR}"/bin
echo -e '\n'

echo 'Creating symlinks'
ln -sfv "${PWD}"/.bash_aliases "${BASE_DIR}"
ln -sfv "${PWD}"/.bash_profile "${BASE_DIR}"
ln -sfv "${PWD}"/.bashrc "${BASE_DIR}"
ln -sfv "${PWD}"/.config/direnv/* "${CONFIG_DIR}"/direnv
ln -sfv "${PWD}"/.config/git/* "${CONFIG_DIR}"/git
ln -sfv "${PWD}"/.config/nvim/* "${CONFIG_DIR}"/nvim
ln -sfv "${PWD}"/.config/starship.toml "${CONFIG_DIR}"
ln -sfv "${PWD}"/.config/tig/* "${CONFIG_DIR}"/tig
ln -sfv "${PWD}"/.config/tmux/* "${CONFIG_DIR}"/tmux
ln -sfv "${PWD}"/.pyenv/version "${BASE_DIR}"/.pyenv/version
ln -sfv "${PWD}"/Brewfile "${BASE_DIR}"
ln -sfv "${PWD}"/bin/* "${BASE_DIR}"/bin
echo -e '\n'

echo 'Setting up fzf'
"${HOMEBREW_PREFIX}"/opt/fzf/install \
    --xdg \
    --key-bindings \
    --completion \
    --no-update-rc
echo -e '\n'

echo 'Setting up Neovim'
curl \
    --fail \
    --location \
    --output "${DATA_DIR}"/nvim/site/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
