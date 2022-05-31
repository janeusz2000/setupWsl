#!/bin/bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update && sudo apt-get upgrade

# disable common paths with windwos [WSL ONLY!]
sudo touch /etc/wsl.conf
sudo echo "[interop]" | sudo tee /etc/wsl.conf
sudo echo "appendWindowsPath = false" | sudo tee -a /etc/wsl.conf
source /etc/wsl.conf

# disable password credentials for changing default terminal to fish
echo "auth sufficient pam_shells.so" | sudo tee /etc/pam.d/chsh
echo "auth sufficient pam_rootok.so" | sudo tee -a /etc/pam.d/chsh
echo "@include common-auth" | sudo tee -a /etc/pam.d/chsh
echo "@include common-account" | sudo tee -a /etc/pam.d/chsh
echo "@include common-session" | sudo tee -a /etc/pam.d/chsh


# install fish and make it default terminal after restart
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install fish -y
chsh -s /usr/bin/fish 

# install npm and bazel
echo "installing npm tools"
sudo apt-get install npm
sudo apt-get install nodejs -y
sudo npm install -g n
sudo n stable
sudo npm install -g @bazel/bazelisk
sudo npm install -g nodemon
sudo npm install --save-dev coc.nvim
sudo npm install -g neovim

# Python
sudo apt install python3-pip
pip3 install neovim
pip3 install pynvim --upgrade

# C++
echo "installing C++ tools"
sudo apt-get install llvm gcc -y

# install lua for neovim tools
echo "Installing lua..."
sudo apt install lua5.3 -y
echo "Lua istallation ended"


echo "Building and installing neovim"
rm ~/neovimTemp -r -d
sudo apt-get install git
mkdir ~/neovimTemp
cd ~/neovimTemp
git clone https://github.com/neovim/neovim.git
cd neovim
echo "installing dependenceis for neovim..."
sudo apt-get install libtool autoconf automake cmake libncurses5-dev g++ pkg-config libtool-bin unzip gettext -y
echo "dependencies installed"
echo "removing old instance of neovim if exists"
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
echo "building neovim"
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
cd ..
sudo rm ~/neovimTemp -r -d

mkdir ~/.config/
mkdir ~/.config/nvim
cd ~/.config/nvim
echo "installing neovim configuration"
git clone https://github.com/janeusz2000/neovim.git
sudo mv ./neovim/* ~/.config/nvim/
sudo rm ./neovim/ -r -d

# creating undo dir in linux directory 
mkdir ~/.temp
mkdir ~/.temp/nvim
mkdir ~/.temp/nvim/undodir

nvim --headless +PlugInstall +qall
echo "Building and installing neovim ended"

echo "Restart required"
exit
