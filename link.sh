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

link_niri()
{
	check_existing "niri"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/niri ~/.config/
		echo "successfully created link for niri"
	fi
}

link_waybar()
{
	check_existing "waybar"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/waybar ~/.config/
		echo "successfully created link for waybar"
	fi
}

link_wayland_tools()
{
	for tool in swaync gsimplecal fuzzel swaylock swayidle ironbar satty
	do
		check_existing "$tool"
		if [[ $? -ne 0 ]]
		then
			ln -sf ~/.config/dotfiles/wayland-tools/$tool ~/.config/
			echo "successfully created link for $tool"
		fi
	done

	# Startup apps are managed by systemd, not niri spawn-at-startup. niri runs
	# as niri.service and BindsTo graphical-session.target, so we wire startup
	# units into niri.service via `add-wants`.
	mkdir -p ~/.config/systemd/user

	# nm-applet has no packaged unit -> ship our own.
	ln -sf ~/.config/dotfiles/wayland-tools/systemd/nm-applet.service ~/.config/systemd/user/nm-applet.service
	# swayidle (idle lock + DPMS) -> ship our own unit.
	ln -sf ~/.config/dotfiles/wayland-tools/systemd/swayidle.service ~/.config/systemd/user/swayidle.service
	systemctl --user daemon-reload 2>/dev/null

	# Tie startup units to the niri session.
	# swaync.service / waybar.service are distro units enabled separately.
	systemctl --user add-wants niri.service nm-applet.service swayidle.service warp-taskbar.service 2>/dev/null

	# Mask the xdg-autostart generator's nm-applet dup so it doesn't race ours.
	systemctl --user mask 'app-nm\x2dapplet@autostart.service' 2>/dev/null
	echo "successfully wired systemd startup units (nm-applet, swayidle, warp-taskbar) into niri.service"
}

link_keyd()
{
	check_existing "keyd"
	if [[ $? -ne 0 ]]
	then
		ln -sf ~/.config/dotfiles/keyd ~/.config/
		echo "successfully created link for keyd"
	fi
	# keyd's daemon only reads /etc/keyd, and that needs root. Run manually:
	echo "  -> run with sudo to finish keyd setup:"
	echo "     sudo ln -sf ~/.config/keyd/default.conf /etc/keyd/default.conf && sudo keyd reload"
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
if [[ "$*" == "niri" ]]; then link_niri "YES"; fi
if [[ "$*" == "waybar" ]]; then link_waybar "YES"; fi
if [[ "$*" == "wayland-tools" ]]; then link_wayland_tools "YES"; fi
if [[ "$*" == "keyd" ]]; then link_keyd "YES"; fi

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
	link_niri
	link_waybar
	link_wayland_tools
	link_keyd
fi

