# Personal dotfile collection

Settings for the following tools are included.

- kitty
- nvim
- tmux
- wezterm
- zsh

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
