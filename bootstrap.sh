# System basic config
echo "Configuring system..."

ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.gitconfig ~/.gitconfig


# Adding repositories

# Spotify
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

apt-get udpate

# Installing tools
echo "Installing tools:"

echo -n "Installing curl, zsh, git, vim, autotools-dev, automake, gcc-multilib, python-dev, ruby-dev, spotify-client... "
apt-get -y install curl zsh git vim autotools-dev automake gcc-multilib python-dev ruby-dev spotify-client
echo "Done."

echo -n "Oh-my-zsh... "
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh gabriel
echo "Done."

echo -n "Making Zsh the default shell"
chsh -s $(which zsh)
echo "Done."

echo "You're all setup! :)"