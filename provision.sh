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
    direnv \
    git \
    htop \
    mosh \
    most \
    pasaffe \
    pwgen \
    python3.6 \
    libpython3.6-dev \
    python3.7 \
    libpython3.7-dev \
    sshuttle \
    terminator \
    tig \
    tmux \
    tree \
    vim \
    xclip

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
