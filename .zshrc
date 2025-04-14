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
export EDITOR=editor

# Podman should ignore that we use cgroups v1
export PODMAN_IGNORE_CGROUPSV1_WARNING=1

# fzf (^T, ^e)
source <(fzf --zsh)
function fuzzyvim() {
  fzf --reverse --multi --select-1 --exit-0 --bind 'enter:become(nvim {})'
}
bindkey -s '^E' "fuzzyvim\n"

eval "$(sheldon source)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

source <(COMPLETE=zsh jj)
source $HOME/.aliases
if [[ -f $HOME/.env ]]; then
  source $HOME/.env
fi
