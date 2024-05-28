#!/bin/bash

# A very simple script to link the requested configs.

if [[ $# -eq 0 ]]
then
	echo 'No args provides. Use "all" or a specific config'
	exit 1
fi

if [[ "$*" == "kitty" ]]; then link_kitty "YES"; fi
if [[ "$*" == "nvim" ]]; then link_nvim "YES"; fi
if [[ "$*" == "wezterm" ]]; then link_wezterm "YES"; fi
if [[ "$*" == "tmux" ]]; then link_tmux "YES"; fi
if [[ "$*" == "zsh" ]]; then link_zsh "YES"; fi

if [[ "$*" == "all" ]]
then
	link_kitty
	link_nvim
	link_wezterm
	link_tmux
	link_zsh
fi

link_kitty()
{
	ln -sf ~/.config/dotfiles/kitty ~/.config/kitty
}

link_nvim()
{
	ln -sf ~/.config/dotfiles/nvim ~/.config/nvim
}

link_wezterm()
{
	ln -sf ~/.config/dotfiles/wezterm ~/.config/wezterm
}

link_tmux()
{
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -sf ~/.config/dotfiles/.tmux.conf ~/.tmux.conf
}

link_zsh()
{
	ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
}
