#!/bin/bash

# basics
sudo apt install curl git

## add needed repos

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# tilix tiling terminal
sudo add-apt-repository ppa:webupd8team/terminix

sudo apt update

## apt repo installs
sudo apt install -y zsh vim i3 rxvt-unicode htop vifm firefox tmux rofi code vlc tilix

## git installs

# tmuxifier
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

# powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# dotfiles
mkdir ~/repos/
git clone https://github.com/tonydero/dotfiles.git ~/repos/dotfiles

## i3-gaps
echo Are you running Ubuntu 16.04 or lower?

read ubvers

if [ $ubvers = 'y' ]
then
  sudo add-apt-repository ppa:aguignard/ppa
  sudo apt-get update
  sudo apt-get install libxcb-xrm-dev
fi

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake

cd ~/repos
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd ~/repos
rm -rf i3-gaps

## polybar
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libjsoncpp-dev libasound2-dev libpulse-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libxcb-cursor-dev

git clone --recursive https://github.com/jaagr/polybar ~/repos/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
cd ~/repos
rm -rf polybar

## installing dotfiles
sudo \cp -rf ~/repos/dotfiles/.zshrc ~/.zshrc
sudo \cp -rf ~/repos/dotfiles/.vimrc ~/.vimrc
sudo \cp -rf ~/repos/dotfiles/.Xresources ~/.Xresources
if [ ! -d ~/.config/i3/ ]
then
  sudo mkdir ~/.config/i3
fi
sudo \cp -rf ~/repos/dotfiles/i3config ~/.config/i3/config
if [ ! -d ~/.config/polybar/ ]
then
  sudo mkdir ~/.config/polybar
fi
sudo \cp -rf ~/repos/dotfiles/pbconfig ~/.config/polybar/config


## chrome
echo Do you want to install Google Chrome?

read chrome

if [ $chrome = 'y' ]
then
  sudo apt-get install libxss1 libappindicator1 libindicator7
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome*.deb
fi
