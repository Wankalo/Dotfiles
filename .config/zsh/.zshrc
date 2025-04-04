### Finally doing my own config
# p10k stuff
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
setopt globdots
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive

# Vi keys in autocomplete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Vi mode stuff
bindkey -v '^?' backward-delete-char
# bindkey -e # Disable vim mode

# History in cache dir
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history
setopt share_history

# Aliases
source $XDG_CONFIG_HOME/zsh/aliases.zsh

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Other options 
setopt auto_cd # cd by typing dir name
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"

# Variables
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# fzf
eval "$(fzf --zsh)"

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

# powerlevel10k might switch to oh my posh
source $XDG_CONFIG_HOME/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
