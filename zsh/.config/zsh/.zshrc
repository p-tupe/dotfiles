#!/usr/bin/zsh

###################
##### OPTIONS #####
###################

setopt append_history         # Immediately append history instead of overwriting
setopt auto_cd                # if only directory path is entered, cd there.
setopt extended_glob          # Extended globbing. Allows using regular expressions with *
setopt hist_expire_dups_first # Remove dups before uniques when trimming
setopt hist_find_no_dups      # Do not display dupes when searching through hist
setopt hist_ignore_all_dups
setopt hist_ignore_dups       # Do not enter command into the history if they are duplicates
setopt hist_ignore_space
setopt hist_save_no_dups      # When writing out the history file, older commands that duplicate newer ones are omitted.
setopt inc_append_history     # save commands are added to the history immediately, otherwise only when shell exits.
setopt no_beep                # No beep
setopt no_case_glob           # Case insensitive globbing
setopt no_check_jobs          # Don't warn about running processes when exiting
setopt numeric_glob_sort      # Sort filenames numerically when it makes sense
setopt rc_expand_param        # Array expension with parameters


###################
##### PLUGINS #####
###################

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


######################
##### COMPLETION #####
######################

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                         # automatically find new executables in path
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path /tmp/cache
zstyle ':completion:*:functions' ignored-patterns '_*'     # Ignore completion functions for commands


##################
##### CONFIG #####
##################

HISTFILE=${ZDOTDIR}/.zhistory
HISTSIZE=1000
SAVEHIST=1000
WORDCHARS=${WORDCHARS//\/[&.;]}       # Don't consider certain characters part of the word
DISABLE_UNTRACKED_FILES_DIRTY="true"  # Disable marking untracked files under VCS as dirty.
DISABLE_AUTO_TITLE="true";


#######################
##### KEYBINDINGS #####
#######################

bindkey -e
zmodload zsh/terminfo
bindkey '^[[3~' delete-char                        # Delete key
bindkey '^[[C'  forward-char                       # Right key
bindkey '^[[D'  backward-char                      # Left key
bindkey '^[[5~' history-beginning-search-backward  # Page up key
bindkey '^[[6~' history-beginning-search-forward   # Page down key


################
##### PATH #####
################


export PATH="$HOME/.local/bin/\
:$HOME/.local/npm/bin\
:$HOME/.docker/bin\
:$HOME/.foundry/bin\
:/opt/homebrew/opt/python@3.13/libexec/bin\
:/opt/homebrew/opt/sqlite/bin\
:/opt/homebrew/opt/ruby/bin\
:/opt/homebrew/opt/openjdk/bin\
:/opt/homebrew/bin\
:/opt/homebrew/sbin\
:/usr/local/bin\
:/usr/local/sbin\
:/usr/bin\
:/usr/sbin\
:/bin\
:/sbin";

function chpwd() {
  if [[ $PWD == /Users/pritesh/Work/simpletire/steer ]]; then useNode20; fi
  if [[ $PWD == /Users/pritesh/Work/simpletire/steer-search-widget ]]; then useNode18; fi
  if [[ $PWD == /Users/pritesh/Work/simpletire/steer-api-definition ]] then useNode14; fi
}


##################
##### PROMPT #####
##################

PROMPT='%1~ · '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{blue}%b'
zstyle ':vcs_info:*' enable git


###############
##### INIT ####
###############

# For z command
. /opt/homebrew/etc/profile.d/z.sh

if [ ! -e "/tmp/run_once" ]; then
  (
  # Inject Window Manager
  cat /Users/pritesh/.local/share/xyz | sudo -S yabai --load-sa &
  # Load SSH Keys
  # Add them to keychain using following command:
  #   ssh-add --apple-use-keychain ~/.ssh/<key>
  /usr/bin/ssh-add --apple-load-keychain &
  # Mark it done
  touch /tmp/run_once
  ) 2> /dev/null
fi
