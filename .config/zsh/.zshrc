# Autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
setopt globdots
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LSCOLORS}"

bindkey -e # Disable vim mode

# History in cache dir
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups


# Aliases
source $XDG_CONFIG_HOME/zsh/aliases.zsh

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh

# Other options 
setopt auto_cd # cd by typing dir name
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"


# yazi wrapper: y
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Neovim Manpages
export MANPAGER='nvim +Man!'

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
