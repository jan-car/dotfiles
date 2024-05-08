## WSL-NOTIFY-SEND ###

wsl-notify-send() {
  MESSAGE=$1
  printf "${HL}Sending notification '${MESSAGE}' to Windows${NC}\n"
  "${HOME}/winhome/.wsl/wsl-notify-send/wsl-notify-send.exe" --category "$WSL_DISTRO_NAME" $1
}



### SYSTEM ###

apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

alias list-manually-installed-packages='
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n "s/^Package: //p" | sort -u)
'
# nala history --installed



### FILES ###

alias cd='z'
alias cdi='zi'
alias dirs='dirs -v'  # clear with dirs -c, navigate with cd ~[number]

alias open-files='xdg-open .'

alias ls='exa --all --icons --group-directories-first --sort type --across'
alias ll='exa --all --icons --group-directories-first --sort type --long --header'
lt() {
  exa --all --icons --group-directories-first --long --header --tree --level=${1:-2}
}

alias fsizes='du -ah . | sort -hr | head -n 10'



### FIND ###

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias bat='batcat'

alias top='bashtop'

alias mani='compgen -c | fzf | xargs man'
alias tldri='compgen -c | fzf | xargs tldr'



### GIT ###

# "export HUB_VERBOSE=1" before execution to get more output!
alias repo-sync='
pushd -q ${REPO_DIR}
for repo in `find -maxdepth 5 -type d -name .git`; do
  (echo -e "${HL}Refreshing $repo:h${NC}"; cd $repo:h; hub sync)
done
popd -q
'

alias repo-sync-gc='
pushd -q ${REPO_DIR}
for repo in `find -maxdepth 5 -type d -name .git`; do
  (echo -e "${HL}Refreshing and cleaning up $repo:h${NC}"; cd $repo:h; hub sync; git gc --aggressive --prune=now)
done
popd -q
'

# checkout master before using the following:
alias git-tag-update='git fetch origin --tags --force'
alias git-list-merged-branches='git branch --merged master --no-color | grep -Ev "master|stable|main"'
alias git-delete-merged-branches='git branch --merged master --no-color | grep -Ev "master|stable|main" | xargs git branch -d'



### DOCKER ###

alias docker-check='
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.RunningFor}}\t{{.Status}}"
'
alias docker-check-slim='
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
'
alias docker-monitor='
watch "docker ps --format \"table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.RunningFor}}\t{{.Status}}\""
'
alias docker-monitor-slim='
watch "docker ps --format \"table {{.ID}}\t{{.Names}}\t{{.Status}}\""
'
alias docker-kill-all='
docker stop $(docker ps -a -q)
'
alias docker-system-size='
docker system df
'



### KUBECTL ###

alias k='kubectl'
ki() {
  resource=$1
  if [ -z "$resource" ]; then
    echo "Error: Please specify the type of resource you want to ge (e.g. pods, service, etc.)."
    return 1
  fi
  shift
  command="$@"
  if [ -z "$command" ]; then
    echo "Error: Command cannot be empty."
    return 1
  fi
  echo "For resource: '$resource', execute command 'kubectl $command <RESOURCE> -n <NAMESPACE>'"
  kubectl get $resource -A --no-headers | fzf | awk '{print $2, $1}' | xargs -n 2 zsh -c "kubectl $command \$0 -n \$1"
}
k-port-forward() {
  port=$1
  if [ -z "$port" ]; then
    echo "Error: Please specify a port (e.g. 19200 for ES)"
    return 1
  fi
  kubectl get svc | fzf | xargs -n 1 zsh -c "kubectl port-forward services/\$0 $port:$port"
}



### SSH ###

alias ssh-clear='keychain --clear'

ssh-load() {
  ssh_folder="$HOME/.ssh"
    # Argument is not provided, offer fuzzy find using fzf
    echo "No argument provided. Please select a file from the '$ssh_folder' folder:"
    selected_file=$(find "$ssh_folder" -type f -name 'id_rsa_*' ! -name '*.pub' | fzf)
    if [[ -n "$selected_file" ]]; then
        echo "Selected file: $selected_file"
        eval `keychain --eval --agents ssh $selected_file`
    else
        echo "No file selected. Exiting."
        return  # Exit the function without stopping the whole shell
    fi
}



### INTELLIJ ###

alias jetbrains-toolbox="${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
alias idea="${HOME}/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/bin/idea.sh"
