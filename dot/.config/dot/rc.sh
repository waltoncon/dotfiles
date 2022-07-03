#!/usr/bin/env bash

[[ -z "${XDG_CACHE_HOME}"  ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z "${XDG_DATA_HOME}"   ]] && export XDG_DATA_HOME="$HOME/.local/share"
[[ -z "${XDG_STATE_HOME}"  ]] && export XDG_STATE_HOME="$HOME/.local/state"

alias cat='bat'         # Use bat instead of cat
alias v="wslview"       # Shortcut for wslview
alias so="ssc open"     # Open project files with SSC
alias cp="cp -i"        # -i (interactive)      prompt before overwrite
alias df='df -h'        # -h (human-readable)   print sizes in powers of 1024 (e.g., 1023M)
alias ls='ls -lAhF'     # -A (almost-all)       do not list implied . and ..
                        # -F (classify)         append indicator (one of */=>@|) to entries
                        # -h (human-readable)   print sizes like 1K 234M 2G etc.
                        # -l                    use a long listing format
alias lt='ls -t'        # -t                    sort by modification time, newest first
alias lz='ls -S'        # -S                    sort by file size, largest first
alias svn="svn --config-dir \"${XDG_CONFIG_HOME}/subversion\""
alias yarn="yarn --use-yarnrc \"${XDG_CONFIG_HOME}/yarn/config\""
alias wget="wget --hsts-file=\"${XDG_CACHE_HOME}/wget-hsts\""

# Open files in Windows File Explorer from inside WSL
function e() {
    explorer.exe "$(wslpath -w $1)"
}

# Start an http server in the specified directory
function h() {
    http-server -o -c5 --no-dotfiles --brotli --utc --log-ip $1
}

# AWS
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
# Deno
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
# Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker-machine"
# Node 
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
# NPM
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
# NVM
export NVM_DIR="${XDG_DATA_HOME}/nvm"
# Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
# SQLite
export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history
# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"