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

	if [[ -e ~/.config/${name} ]]
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

link_ghostty()
{
	check_existing "ghostty"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/ghostty ~/.config/
		echo "successfully created link for ghostty"
	fi
}

link_tmux()
{
	if [[ ! -d ~/.tmux/plugins/tpm ]]
	then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
	ln -sf ~/.config/dotfiles/.tmux.conf ~/.tmux.conf
	echo "successfully created link for tmux"
}

link_zsh()
{
	ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
	echo "successfully created link for zsh"
}

link_sheldon()
{
	check_existing "sheldon"
	ln -sf ~/.config/dotfiles/sheldon ~/.config/
	echo "successfully created link for sheldon"
}

link_starship()
{
	check_existing "starship.toml"
	ln -sf ~/.config/dotfiles/starship.toml ~/.config/starship.toml
	echo "successfully created link for starship"
}

link_fish()
{
	check_existing "fish"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/fish ~/.config/
		echo "successfully created link for fish"
	fi
}

link_jj()
{
	check_existing "jj"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/jj ~/.config/
		echo "successfully created link for jj"
	fi
}

if [[ "$*" == "kitty" ]]; then link_kitty "YES"; fi
if [[ "$*" == "nvim" ]]; then link_nvim "YES"; fi
if [[ "$*" == "wezterm" ]]; then link_wezterm "YES"; fi
if [[ "$*" == "ghostty" ]]; then link_ghostty "YES"; fi
if [[ "$*" == "tmux" ]]; then link_tmux "YES"; fi
if [[ "$*" == "zsh" ]]; then link_zsh "YES"; fi
if [[ "$*" == "sheldon" ]]; then link_sheldon "YES"; fi
if [[ "$*" == "starship" ]]; then link_starship "YES"; fi
if [[ "$*" == "fish" ]]; then link_fish "YES"; fi
if [[ "$*" == "jj" ]]; then link_jj "YES"; fi

if [[ "$*" == "all" ]]
then
	link_kitty
	link_nvim
	link_wezterm
	link_ghostty
	link_tmux
	link_zsh
	link_sheldon
	link_starship
	link_fish
	link_jj
fi

