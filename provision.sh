#!/bin/sh

# Provisions a machine with my development environment.

CODE_DIR="$HOME/Code"
DOTFILES_DIR="$CODE_DIR/dotfiles"

# Preliminaries
if ! [ "$HOME/.ssh/id_rsa" ]; then
    echo "Missing private key"
fi

sudo apt update
sudo apt --yes upgrade
sudo apt --yes autoremove

# Miscellaneous Dependencies
sudo apt --yes install \
    build-essential \
    curl \
    git \
    htop \
    mosh \
    pasaffe \
    pwgen \
    terminator \
    tig \
    tmux \
    vim \
    xclip

sudo snap install slack --classic
sudo snap install spotify

# Python
sudo apt --yes install python3-pip

# Vex
pip3 install --user vex
echo '' >> $HOME/.profile
echo '# Include command-line Python tools' >> $HOME/.profile
echo 'PATH="$PATH:$HOME/.local/bin"' >> $HOME/.profile
mkdir -v "$HOME/.virtualenvs"

# Dotfiles
mkdir -v $CODE_DIR
git clone -v git@github.com:iaindillingham/dotfiles.git $DOTFILES_DIR

ln -fsv "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
ln -fsv "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -fsv "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"
ln -fsv "$DOTFILES_DIR/gitmessage" "$HOME/.gitmessage"
ln -fsv "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
ln -fsv "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"

# Vundle
git clone -v https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall
