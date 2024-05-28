# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/programs/zig:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Podman should ignore that we use cgroups v1
export PODMAN_IGNORE_CGROUPSV1_WARNING=1

eval "$(sheldon source)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

source $HOME/.aliases
