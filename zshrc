source /home/se/.config/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle debian
antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme kphoen
#antigen theme bira

antigen apply

export GOROOT=/usr/local/go
export GOPATH=/home/se/programs/go_path
export RUST_SRC_PATH=/usr/local/rust-src/src
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:/home/se/programs/elixir/bin:/home/se/.cargo/bin

export NVIM_TUI_ENABLE_TRUE_COLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.cargo/bin:$PATH"
