# Bash setup
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Add user binaries to path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# Add user private binaries to path
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
