# Standard RC
[ -e ~/.config/shell/init ] && source ~/.config/shell/init

# Setup Nix
[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh;

# Setup NVM
[ -e "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Lines configured by zsh-newuser-install
HISTFILE="${ZSH_STATE}/history"
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

# Makes autocompletion work on aliases
setopt complete_aliases

bindkey "^[[1;3C" forward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[3~" delete-char
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

eval "$(starship init zsh)"