#!/bin/zsh

# Global env
export LC_ALL=en_US.UTF-8
export MANPAGER='nvim +Man!'
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERMINAL=kitty
export BROWSER=firefox
export KEYTIMEOUT=1
export XDG_CONFIG_HOME="$HOME/.config"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export HOMEBREW_NO_ENV_HINTS=1
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
export DISABLE_TELEMETRY=1

# User aliases
[[ -r ~/.config/zsh/.aliases ]] && source ~/.config/zsh/.aliases

# Tell zsh where to look for our dotfiles.
ZDOTDIR=~/.config/zsh
