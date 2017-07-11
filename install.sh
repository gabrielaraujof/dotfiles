# System basic config
echo "Configuring system..."



### Basic tools ###

echo "Updating package list..."
apt update -yqq
echo "Done."

echo "Installing basic tools..."
apt -y install \
  apt-transport-https ca-certificates software-properties-common \
  curl git zsh vim gimp inkscape firefox chromium-browser vlc \
  autotools-dev automake gcc-multilib python-dev ruby-dev
echo "Done."



### Adding repositories ###

# Spotify
echo "Adding spotify repository..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb [arch=amd64] http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
echo "Done..."

# VSCode
echo "Adding VSCode repository..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main | tee /etc/apt/sources.list.d/vscode.list

# Skype
echo "Adding Skype repository..."
curl -fsSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo deb [arch=amd64] https://repo.skype.com/deb stable main | tee /etc/apt/sources.list.d/skype-stable.list

# Docker
echo "Adding Docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable | tee /etc/apt/sources.list.d/docker.list

# Node
echo "Adding Nodejs repository..."
curl -fsSL https://deb.nodesource.com/setup_8.x | bash -

# Dropbox
echo "Adding Dropbox repository..."
apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
echo deb [arch=amd64] http://linux.dropbox.com/ubuntu xenial main | tee /etc/apt/sources.list.d/dropbox.list

# Chrome
echo "Adding Google Chrome repository..."
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/chrome.list

# Slack
echo "Adding Slack repository..."
curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
echo deb [arch=amd64] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main | tee /etc/apt/sources.list.d/slack.list

# Dotnet Core
echo "Adding .Net Core repository..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
echo deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main | tee /etc/apt/sources.list.d/dotnetdev.list

# Brave
echo "Adding Brave repository..."
curl -fsSL https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | apt-key add -
echo deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt serena main | tee /etc/apt/sources.list.d/brave.list



### Installing packages ###

echo "Updating package list..."
apt update -yqq
echo "Done."

# Installing tools
echo "Installing workspace tools..."
apt -y install spotify-client code skypeforlinux \
  docker-ce nodejs dropbox google-chrome-stable slack \
  dotnet-dev-1.0.4 brave
echo "Done."



# OH-MY-ZSH
echo "Installing oh-my-zsh... "
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash -
chsh -s /bin/zsh gabriel
echo "Done."

# Pyenv
echo "Installing pyenv..."
curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash -
~/.pyenv/bin/pyenv install 3.6.0
echo "Done."

# Setting up ZSH
echo "Making Zsh the default shell"
chsh -s $(which zsh)
echo "Done."

# Setting up docker to run without sudo
echo "Setting up docker..."
groupadd docker
gpasswd -a $USER docker
echo "Done."

# Creating symlinks
echo "Copying configuration files..."
# curl -fso ~/.zshrc https://raw.githubusercontent.com/gabrielaraujof/dotfiles/master/.zshrc
curl -fso ~/.gitconfig https://raw.githubusercontent.com/gabrielaraujof/dotfiles/master/.gitconfig
echo "Done."

echo "You're all setup! :)"
