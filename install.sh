#!/usr/bin/env bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

# Source Nix temporarily
source ~/.nix-profile/etc/profile.d/nix.sh;

# Install packages with Nix
nix-env -iA \
    nixpkgs.bat \
    nixpkgs.deno \
    nixpkgs.fzf \
    nixpkgs.git \
    nixpkgs.imagemagick \
    nixpkgs.jq \
    nixpkgs.mediainfo \
    nixpkgs.pandoc \
    nixpkgs.ripgrep \
    nixpkgs.sqlite \
    nixpkgs.starship \
    nixpkgs.stow \
    nixpkgs.subversion \
    nixpkgs.tealdeer \
    nixpkgs.unzip \
    nixpkgs.yarn \
    nixpkgs.zsh

# Remove profile to use stowed version
rm ~/.profile

# stow dotfiles
stow git
stow npm
stow shell
stow subversion
stow zsh

# Source the shell files while installing
source "~/.config/shell/init"

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Disable sudo message
[ -e "/etc/bash.bashrc" ] && sudo sed -i '/sudo hint/,/^fi/d' /etc/bash.bashrc

# Disable MOTD
[ -e "/etc/default/motd-news" ] && sudo sed -i 's/ENABLED=1/ENABLED=0/' /etc/default/motd-news
