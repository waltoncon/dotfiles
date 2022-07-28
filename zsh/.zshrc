# Standard RC
[ -e ~/.config/shell/init ] && source ~/.config/shell/init

# Setup Nix
[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh;

# Setup NVM
[ -e "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Lines configured by zsh-newuser-install
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
# End of lines added by compinstall


eval "$(starship init zsh)"