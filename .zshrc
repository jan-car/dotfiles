# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md
# Advanced tips: https://github.com/romkatv/zsh4humans/blob/master/tips.md
# Migration of zsh4humans: https://github.com/romkatv/zsh4humans/issues/94

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Don't start tmux.
# zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Prompt:
z4h bindkey z4h-eof Ctrl+D
setopt ignore_eof
POSTEDIT=$'\n\n\e[2A'
z4h bindkey z4h-accept-line Enter

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'yes'
# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
# zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# zstyle ':z4h:ssh:*.example-hostname2' enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.zshaliases'

# Start ssh-agent if it's not running yet.
zstyle ':z4h:ssh-agent:' start yes

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
# z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
# z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory
zstyle ':z4h:fzf-dir-history' fzf-bindings tab:repeat
zstyle ':z4h:cd-down'         fzf-bindings tab:repeat
z4h bindkey z4h-fzf-dir-history Alt+Down

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md
zstyle ':completion:*:ssh:argument-1:'       tag-order  hosts users
zstyle ':completion:*:scp:argument-rest:'    tag-order  hosts files users
zstyle ':completion:*:(ssh|scp|rdp):*:hosts' hosts
zstyle ':z4h:*' fzf-flags --color=hl:42,hl+:42 --border --info=inline
# for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done  #colors

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots  # no special treatment for file names with a leading dot
setopt auto_menu  # require NO extra TAB press to open the completion menu



### GENERAL PERSONAL CONFIG ###

# Quick colors:
SC_RED='\e[1;31m'
SC_GREEN='\e[1;32m'
SC_YELLOW='\e[1;33m'
SC_BLUE='\e[1;34m'
SC_WHITE='\e[1;37m'
NC='\e[0m' # No Color
HL=$SC_GREEN # Highlight (for easy switching)

# autosuggest strategy config:
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Use Windows default Browser:
export BROWSER="/mnt/c/Users/Jan.Caron/AppData/Local/Vivaldi/Application/vivaldi.exe"

# Repository directory:
export REPO_DIR="$HOME/repos"

# Path:
export PATH=$(cat <<EOF
${KREW_ROOT:-$HOME/.krew}/bin
${HOME}/.local/bin
EOF
):$PATH

# TODO: Add /mnt/c/Users/Jan.Caron/AppData/Local/Programs/Microsoft VS Code/bin or is it there by default from Windows?

# Add own aliases:
source ~/.zshaliases

source ~/.asdf/asdf.sh
