set -g fish_history_max 10000

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
	fzf --fish | source
    mise activate fish | source
    atuin init fish --disable-up-arrow | source

    source $HOME/.aliases

end
