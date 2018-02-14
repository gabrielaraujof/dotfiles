#!/bin/bash

ORANGE='\033[0;33m'
NC='\033[0m' # No Color

cecho() {
	MSG=$1
	echo -e "${ORANGE}${MSG}${NC}"
}


# System basic config
cecho "Configuring system..."


### Basic tools ###

cecho "Updating package list..."
apt update -yqq

cecho "Installing basic tools..."
apt-get install -yyq \
  apt-transport-https ca-certificates software-properties-common \
  curl git zsh vim gimp inkscape firefox chromium-browser vlc \
  autotools-dev automake gcc-multilib



### Adding repositories ###

# VSCode
cecho "Adding VSCode repository..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main | tee /etc/apt/sources.list.d/vscode.list

# Sublime
cecho "Adding Sublime-text repository"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# # Node
cecho "Adding Nodejs repository..."
curl -fsSL https://deb.nodesource.com/setup_8.x | bash -

# # Dropbox
# echo "Adding Dropbox repository..."
# apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
# echo deb [arch=amd64] http://linux.dropbox.com/ubuntu xenial main | tee /etc/apt/sources.list.d/dropbox.list

# # Chrome
# echo "Adding Google Chrome repository..."
# curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# echo deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/chrome.list

# # Dotnet Core
# echo "Adding .Net Core repository..."
# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
# echo deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main | tee /etc/apt/sources.list.d/dotnetdev.list

# # Brave
# echo "Adding Brave repository..."
# curl -fsSL https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | apt-key add -
# echo deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt serena main | tee /etc/apt/sources.list.d/brave.list



# ### Installing packages ###

cecho "Updating package list..."
apt update -yqq

# # Installing tools
cecho "Installing  tools..."
apt install -yqq snapd code sublime-text skypeforlinux \
  docker-ce nodejs dropbox google-chrome-stable slack \
  dotnet-dev-1.0.4 brave
echo "Done."

snap install spotify skype slack

# # OH-MY-ZSH
cecho "Installing oh-my-zsh... "
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash -
cecho "Making Zsh the default shell"
chsh -s $(which zsh) $(whoami)

# # Pyenv
# echo "Installing pyenv..."
# curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash -
# ~/.pyenv/bin/pyenv install 3.6.0
# echo "Done."

# # Setting up docker to run without sudo
cecho "Setting up docker..."
groupadd docker
gpasswd -a $USER docker

# # Creating symlinks
cecho "Copying zsh profile..."
curl -fso ~/.zshrc https://raw.githubusercontent.com/gabrielaraujof/dotfiles/master/.zshrc
cecho "Copying git global config..."
curl -fso ~/.gitconfig https://raw.githubusercontent.com/gabrielaraujof/dotfiles/master/.gitconfig

cecho "You're all setup! :)"
