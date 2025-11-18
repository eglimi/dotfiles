set -g fish_history_max 10000

if status is-interactive
    # Commands to run in interactive sessions can go here

    # starship init fish | source
	fzf --fish | source
    if command -q mise
        mise activate fish | source
    end
    atuin init fish --disable-up-arrow | source
    devbox completion fish | source
    devbox global shellenv --init-hook | source

    source $HOME/.aliases

end
