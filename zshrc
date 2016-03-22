source ~/.zplug/zplug

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/heroku", from:oh-my-zsh
zplug "plugins/debian", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
#zplug "zsh-users/zsh-autosuggestions"

# must be last plugins
zplug "zsh-users/zsh-syntax-highlighting"
#zplug "plugins/history-substring-search", from:oh-my-zsh

zplug "themes/bira", from:oh-my-zsh

zplug load

export GOROOT=/usr/local/go
export GOPATH=/home/se/programs/go_path
export RUST_SRC_PATH=/usr/local/rust-src/src
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:/home/se/programs/elixir/bin:/home/se/.cargo/bin

export NVIM_TUI_ENABLE_TRUE_COLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
