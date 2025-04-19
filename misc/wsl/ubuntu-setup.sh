#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /home/kyle/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/kyle/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential

# Install build dependencies
sudo apt-get update
sudo apt-get install git
sudo apt-get install gcc

# Install packages via Homebrew
brew install neovim
brew install ripgrep
brew install fd
brew install python
brew install node
brew install lazygit
brew install gcc

# Create necessary directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/lazygit

# Copy configuration files
cp -r /mnt/c/code/nvim-setup/ ~/.config/nvim/
# cp /mnt/c/code/docker/.gitconfig ~/.gitconfig
# cp /mnt/c/code/docker/lazygitconfig.yml ~/.config/lazygit/config.yml
#
git config --global core.autocrlf true
