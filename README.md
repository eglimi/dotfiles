# Personal dotfile collection

Settings for the following tools are included.

- kitty
- nvim
- tmux
- wezterm
- zsh
- niri
- waybar

It is assumed that the repository is cloned into `~/.config/dotfiles`.

```
git clone git@github.com:eglimi/dotfiles.git ~/.config/dotfiles
```

## Link script

Use the [`link.sh`](./link.sh) script to automatically link the files and directories to the correct location in the home directory. The script can either link everything or only specific tools by using cli arguments. For example.

```
# link the kitty configuration.
# Instead of kitty, use any of the tools listed above.
./link.sh kitty

# Link all tools
./link.sh all
```

## Tmux

The tmux configuration uses plugins, therefore, the `link.sh` script clones the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) automatically.

## niri (Arch)

Packages:

```
sudo pacman -S niri waybar fuzzel swaylock swayidle swaync swaybg \
  grim slurp wl-clipboard brightnessctl ttf-jetbrains-mono-nerd gsimplecal
```

```
./link.sh niri
./link.sh waybar
./link.sh wayland-tools   # swaync, gsimplecal, fuzzel, swaylock, ironbar + waybar.service
```

Notes:

- `niri` ships its own GDM session entry; pick it at login.
- Brightness keys: `sudo gpasswd -a $USER video`, then re-login.
- waybar runs as a systemd user service (`waybar.service`, `Restart=always`), linked by
  `wayland-tools`. niri autostart starts it (`systemctl --user start waybar.service`); systemd
  respawns it if it dies (e.g. output change). The unit deliberately drops the
  `graphical-session.target` dependency because this niri is launched as a bare `niri --session`
  (cargo build, session units not installed). On Arch via `pacman` niri, the systemd
  `niri-session` path activates that target — you can then re-add the standard dep / use the
  distro waybar unit instead of this override.
- waybar is current on Arch → use native modules instead of the Ubuntu workarounds:
  - `custom/workspaces` + `niri-workspaces.sh` → native `niri/workspaces` / `niri/window`.
  - gsimplecal → waybar's native clock calendar (drop gsimplecal + its niri window-rule).
  - Re-check other custom/scripted modules; newer waybar likely has natives.
