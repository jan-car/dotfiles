# history config:
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# fzf config:
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf "$@" --preview-window=50%,border-double,right --preview 'exa --all --icons --group-directories-first --tree --level=3 {}' ;;
    export|unset) fzf "$@" --preview-window=50%,border-double,bottom --preview "eval 'echo \$'{}"                                               ;;
    ssh)          fzf "$@" --preview-window=50%,border-double,right --preview 'dig {}'                                                          ;;
    *)            fzf "$@" --preview-window=50%,border-double,right --preview 'bat -n --color=always {}'                                        ;;
  esac
}
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview-window=50%,border-double,right --preview 'exa --all --icons --group-directories-first --tree --level=3 {2}'"

# autosuggest strategy config:
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
