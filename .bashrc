#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# FZF auto-completion and keybindings
if command -v fzf &> /dev/null; then
	source /usr/share/fzf/key-bindings.bash
	source /usr/share/fzf/completion.bash
	alias inspkg="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
	alias insaur="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
	alias rmpkg="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
	alias rmaur="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"
fi
