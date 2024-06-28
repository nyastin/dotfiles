export PATH=$PATH:$HOME/.local/share/bob/nvim-bin

eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"
eval "$(starship init zsh)"

export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

alias cd="z"
