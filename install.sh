#!/usr/bin/env bash

# Install Nix
if ! which nix-env > /dev/null; then
    sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

    # Source Nix temporarily
    source ~/.nix-profile/etc/profile.d/nix.sh;
fi

# Install packages with Nix
nix-env -iA \
    nixpkgs.bat \
    nixpkgs.deno \
    nixpkgs.fd \
    nixpkgs.ffmpeg \
    nixpkgs.fzf \
    nixpkgs.gh \
    nixpkgs.git \
    nixpkgs.gnome.gnome-keyring \
    nixpkgs.imagemagick \
    nixpkgs.jq \
    nixpkgs.mediainfo \
    nixpkgs.pandoc \
    nixpkgs.ripgrep \
    nixpkgs.sd \
    nixpkgs.skim \
    nixpkgs.sqlite \
    nixpkgs.starship \
    nixpkgs.stow \
    nixpkgs.subversion \
    nixpkgs.tealdeer \
    nixpkgs.unzip \
    nixpkgs.yarn \
    nixpkgs.zsh

# Remove profile to use stowed version
[ ! -L ~/.profile ] && rm ~/.profile

# stow dotfiles
stow fd
stow fnm
stow git
stow npm
stow shell
stow starship
stow subversion
stow zsh

# Source the shell files while installing
DIR=$(dirname "$0")
source $DIR/shell/.config/shell/alias
source $DIR/shell/.config/shell/env
source $DIR/shell/.config/shell/func

# Create required files and folders
[ ! -e "${FNM_DIR}" ] && mkdir -p "${FNM_DIR}"
[ ! -e "${ZSH_STATE}" ] && mkdir -p "${ZSH_STATE}"

# Install FNM
if [[ ! -e ${XDG_DATA_HOME}/fnm/fnm ]]; then
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "${XDG_DATA_HOME}/fnm" --skip-shell
fi

FNMCMD=${XDG_DATA_HOME}/fnm/fnm

# Install current Node LTS
$FNMCMD install --lts

# Install latest Node version
$FNMCMD ls-remote | sort -V | tail -n 1 | xargs $FNMCMD install

# add zsh as a login shell
if ! grep -q "$(command -v zsh)" /etc/shells; then
    command -v zsh | sudo tee -a /etc/shells
fi

# use zsh as default shell
CURRENT_SHELL=$(cat /etc/passwd | grep $USER | awk -F: '{print $NF}')
if [[ "$CURRENT_SHELL" != "$(command -v zsh)" ]]; then
    sudo chsh -s $(which zsh) $USER
fi

# Disable sudo message
[ -e "/etc/bash.bashrc" ] && sudo sed -i '/sudo hint/,/^fi/d' /etc/bash.bashrc

# Disable MOTD
[ -e "/etc/default/motd-news" ] && sudo sed -i 's/ENABLED=1/ENABLED=0/' /etc/default/motd-news

# Setup WSL drive mounting
if [[ "$(< /proc/sys/kernel/osrelease)" == *"microsoft"* ]]; then 
    if ! grep -Pzoq "\[automount]\nenabled=false" /etc/wsl.conf; then
        printf "[automount]\nenabled=false" | sudo tee -a /etc/wsl.conf
    fi

    if ! grep -q "C: /mnt/c drvfs defaults 0 0" /etc/fstab; then
        echo "C: /mnt/c drvfs defaults 0 0" | sudo tee -a /etc/fstab
    fi

    if ! grep -q "G: /mnt/g drvfs defaults 0 0" /etc/fstab; then
        echo "G: /mnt/g drvfs defaults 0 0" | sudo tee -a /etc/fstab
    fi
fi

printf "\n\n\nRelaunch your session to continue\n\n\n"
