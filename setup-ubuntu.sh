#!/bin/bash
## This script is used to setup a new Ubuntu machine for development.
echo "========================"
echo "Ubuntu Development Setup"
echo "========================"
echo ""
echo "This script will install the following:"
echo "- Base packages"
echo "- Development packages"
echo "- Sway packages"
echo "- 1Password"
echo "- Docker"
echo "- Starship prompt"
echo ""
echo "Please review the script before running it."
read -p "Press [Enter] to continue or [Ctrl+C] to cancel..."

# Validate if operating system is Ubuntu
if [ ! grep -q "Ubuntu" /etc/os-release]; then 
  echo "This script is only for Ubuntu!"
  exit 1
fi

# Update package list
echo "Updating package list..."
sudo apt update

echo "Installing base packages..."
sudo apt install -y build-essential git curl wget stow

# Download dotfiles
echo "Cloning dotfiles repository..."
cd $HOME
git clone https://github.com/rutger1140/dotfiles.git
cd dotfiles
stow .

echo "Installing development packages..."
sudo apt install -y neovim tmux zsh htop tree nmap net-tools 

echo "Installing Sway packages..."
sudo apt install -y sway swaylock swayidle waybar fuzzel 

# Install 1Password
echo "Installing 1Password..."
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install -y 1password

# Install Docker
echo "Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER

# Set shell to zsh
chsh -s $(which zsh)

# Install starship prompt
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh

source ~/.zshrc
echo "Ubuntu setup complete!"
