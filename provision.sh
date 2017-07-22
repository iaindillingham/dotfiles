#!/bin/sh

# Provisions a machine with my development environment.

CODE_DIR="$HOME/Code"
DOTFILES_DIR="$CODE_DIR/dotfiles"

# Preliminaries
sudo apt update
sudo apt --yes upgrade
sudo apt --yes autoremove

# Dependencies
sudo apt --yes install git terminator tmux vim xscreensaver
sudo apt --yes install i3 suckless-tools

# Dotfiles
mkdir -v $CODE_DIR
git clone -v git@github.com:iaindillingham/dotfiles.git $DOTFILES_DIR

ln -fsv "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
ln -fsv "$DOTFILES_DIR/d3.sh" "$HOME/d3.sh"
ln -fsv "$DOTFILES_DIR/django.sh" "$HOME/django.sh"
ln -fsv "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -fsv "$DOTFILES_DIR/global_gitignore" "$HOME/.global_gitignore"
ln -fsv "$DOTFILES_DIR/global_gitmessage" "$HOME/.global_gitmessage"
ln -fsv "$DOTFILES_DIR/i3" "$HOME/.config"
ln -fsv "$DOTFILES_DIR/latex.sh" "$HOME/latex.sh"
ln -fsv "$DOTFILES_DIR/terminator" "$HOME/.config"
ln -fsv "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
ln -fsv "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"

# Vundle
git clone -v https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall
