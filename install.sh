#!/usr/bin/env bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

# Source Nix temporarily
source ~/.nix-profile/etc/profile.d/nix.sh;

# Install packages with Nix
nix-env -iA \
    nixpkgs.bat \
    nixpkgs.deno \
    nixpkgs.fd \
    nixpkgs.ffmpeg \
    nixpkgs.fzf \
    nixpkgs.git \
    nixpkgs.gnome.gnome-keyring \
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
stow fd
stow git
stow npm
stow nvm
stow shell
stow subversion
stow zsh

# Source the shell files while installing
DIR=$(dirname "$0")
source $DIR/shell/.config/shell/alias
source $DIR/shell/.config/shell/env
source $DIR/shell/.config/shell/func

# Create required files and folders
mkdir -p "${FNM_DIR}"
mkdir -p $(dirname $WGETRC)
mkdir -p "${ZSH_STATE}"
touch "${WGETRC}"

# Install FNM
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "${XDG_DATA_HOME}/fnm" --skip-shell

# Install current Node LTS
${XDG_DATA_HOME}/fnm/fnm install --lts

# Install latest Node version
${XDG_DATA_HOME}/fnm/fnm ls-remote | sort -V | tail -n 1 | xargs ${XDG_DATA_HOME}/fnm/fnm install

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Disable sudo message
[ -e "/etc/bash.bashrc" ] && sudo sed -i '/sudo hint/,/^fi/d' /etc/bash.bashrc

# Disable MOTD
[ -e "/etc/default/motd-news" ] && sudo sed -i 's/ENABLED=1/ENABLED=0/' /etc/default/motd-news

# Setup WSL drive mounting
if [[ "$(< /proc/sys/kernel/osrelease)" == *"microsoft"* ]]; then 
    printf "[automount]\nenabled=false" | sudo tee -a /etc/wsl.conf
    echo "C: /mnt/c drvfs defaults 0 0" | sudo tee -a /etc/fstab
    echo "G: /mnt/g drvfs defaults 0 0" | sudo tee -a /etc/fstab
fi

printf "\n\n\nRelaunch your session to continue\n\n\n"
