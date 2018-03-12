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
    chromium-browser \
    curl \
    firefox \
    git \
    gitk \
    htop \
    i3 \
    nginx \
    openssh-server \
    openvpn \
    pasaffe \
    suckless-tools \
    terminator \
    tmux \
    vim \
    virtualbox \
    xclip \
    xscreensaver \
    xscreensaver-gl \
    xscreensaver-gl-extra

# PostgreSQL
sudo apt --yes install postgresql-9.5-postgis-2.2 postgresql-server-dev-9.5

# MySQL
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password root'
sudo apt --yes install mysql-server-5.7 libmysqlclient-dev
mysql --user=root --password=root --execute="
    CREATE USER '`whoami`'@'localhost';
    GRANT ALL PRIVILEGES ON *.* TO '`whoami`'@'localhost';"

# Python
sudo apt --yes install python-pip python3-pip
pip install --upgrade pip
pip3 install --upgrade pip

# Vex
pip install --user vex
pip3 install --user vex
echo '' >> $HOME/.profile
echo '# Include command-line Python tools' >> $HOME/.profile
echo 'PATH="$PATH:$HOME/.local/bin"' >> $HOME/.profile
mkdir -v "$HOME/.virtualenvs"

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

# Vim
mkdir -p "$HOME/.vim/ftplugin"
ln -fsv "$DOTFILES_DIR/javascript.vim" "$HOME/.vim/ftplugin"

# HipChat
sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -
sudo apt update
sudo apt --yes install hipchat4

# Node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt --yes install nodejs

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
