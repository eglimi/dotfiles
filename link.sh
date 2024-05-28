#!/bin/bash

# A very simple script to link the requested configs.

if [[ $# -eq 0 ]]
then
	echo 'No args provides. Use "all" or a specific config'
	exit 1
fi

check_existing()
{
	local name="$1"
	if [[ -L ~/.config/${name} ]]
	then
		echo "${name} is already a link"
		return 0
	fi

	if [[ -d ~/.config/${name} ]]
	then
		mkdir -p ~/.config/dotfiles_backup
		mv -f ~/.config/${name} ~/.config/dotfiles_backup
		echo "Moved existing ${name} configuration to ~/.config/dotfiles_backup/${name}"
	fi
	return 1
}

link_kitty()
{
	check_existing "kitty"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/kitty ~/.config/
		echo "successfully created link for kitty"
	fi
}

link_nvim()
{
	check_existing "nvim"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/nvim ~/.config/
		echo "successfully created link for nvim"
	fi
}

link_wezterm()
{
	check_existing "wezterm"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/wezterm ~/.config/
		echo "successfully created link for wezterm"
	fi
}

link_tmux()
{
	if [[ ! -d ~/.tmux/plugins/tpm ]]
	then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
	ln -sf ~/.config/dotfiles/.tmux.conf ~/.tmux.conf
}

link_zsh()
{
	ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
}

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

