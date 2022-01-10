# vim: ft=bash
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

load_plugin() {
	main_file=$XDG_CONFIG_HOME/zsh/plugins/$1/$1.zsh
	plug_file=$XDG_CONFIG_HOME/zsh/plugins/$1/$1.plugin.zsh
	if [ -f $main_file ]; then
		source $main_file
	elif [ -f $plug_file ]; then
		source $plug_file
	fi
}

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/home/paulw/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile

HISTSIZE=2000
SAVEHIST=10000
setopt autocd
setopt share_history
unsetopt beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# Aliases
source ~/.zsh_aliases

# Plugins
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_plugin zsh-syntax-highlighting
load_plugin zsh-interactive-cd

#eval "$(starship init zsh)"
# eval "$(zoxide init zsh)"

# Keybindings
# bindkey -s '^E' "ranger\n"
bindkey -s '^f' "fzf\n"
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Load powerlevel10k prompt
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh//.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/nvm/init-nvm.sh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
