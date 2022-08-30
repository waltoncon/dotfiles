# Standard RC
[ -e ~/.config/shell/init ] && source ~/.config/shell/init

# Setup Nix
[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh;

# Setup FNM
eval "$(fnm env --use-on-cd)"

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

setopt no_bare_glob_qual
setopt no_bang_hist

bindkey "^[[1;3C" forward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[3~" delete-char
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

autoload -U select-word-style
select-word-style bash

# Disable the ZSH builtin which re-runs previous command
disable r

eval "$(starship init zsh)"
