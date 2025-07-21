fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/programs/zig
fish_add_path $HOME/programs/podman/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/go/bin

# Environment variables
set -gx EDITOR editor
set -gx LESS '--quit-if-one-screen --ignore-case --chop-long-lines --RAW-CONTROL-CHARS --no-init --tabs=4 --shift=4'

if test -f $HOME/.env
	source $HOME/.env
end
