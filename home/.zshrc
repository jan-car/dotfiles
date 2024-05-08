# ORDER: env.zsh → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# TODO: go through the list here: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    aliases
    asdf
    aws
    azure
    colored-man-pages
    copybuffer
    copyfile
    dirpersist
    docker
    emoji
    extract
    git
    helm
    kubectl
    magic-enter
    mvn
    npm
    pip
    podman
    poetry
    python
    safe-paste
    ssh-agent
    systemadmin
    terraform
    zoxide
    fzf-zsh-plugin
    zsh-autosuggestions
    zsh-syntax-highlighting
    xxh-plugin-zsh-ohmyzsh
)
source $ZSH/oh-my-zsh.sh


# # The following lines were added by compinstall
# zstyle :compinstall filename "~/.zshrc"
# # Initialis completion and compatibility with bash:
# autoload -U +X bashcompinit && bashcompinit
# autoload -U +X compinit && compinit
# # End of lines added by compinstall

# Initialis zoxide (cd replacement: https://github.com/ajeetdsouza/zoxide):
# eval "$(zoxide init zsh)"

# kubectl autocompletion:
# source <(kubectl completion zsh)

# Add asdf completions:
##source "$HOME/.asdf/plugins/java/set-java-home.zsh"  # TODO: simply delete?
# [ -f ~/.asdf/completions/asdf.bash ] && source ~/.asdf/completions/asdf.bash

# Set up fzf key bindings and fuzzy completion (needs https://github.com/junegunn/fzf?tab=readme-ov-file#using-git to work!)
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Alias definitions:
# [ -f ~/.aliases ] && source  ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initialise ssh agent in this shell:
# (needs one prior run of `ssh-init` script in `.aliases` per session, doesn't fail if it didn't happen, yet):
# TODO: MAKE IT A LOOP!!! Maybe put it into an alias function and call it here? is that possible?
eval `keychain --noask --quiet --eval --agents ssh id_rsa_bs`

# Use ssh agent relay script to connect KWindows OpenSSH (gets keys from KeypassXC) and WSL OpenSSH:
# ${HOME}/opt/wsl-ssh-agent-relay -v start  >/dev/null 2>&1
# export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock


# TODO: Create a special oh-my-zsh local.zsh file that contains just a comment and that can be used to modify specific behaviour for the current system (TNG/BS/private)?
