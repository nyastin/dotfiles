if [[ -f "$HOME/.private.sh" ]]; then
  source "$HOME/.private.sh"
fi

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
alias python=python3
alias pip=pip3

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

alias cd="z"

# restore () {
# if [[ "$1" == "omni" ]]
# then
#   tmux split-window -h -l 50 'docker compose up'
#   tmux split-window -v 'cd packages/db && pnpm run db:studio --browser none'
#   tmux last-pane
#   pnpm run dev --filter @omni/internal "${@:2}"
# elif [[ "$1" == "ecm" ]]
# then
#   echo "TODO: ecm"
# else
#   echo "Invalid argument. Please provide 'omni' or 'ecm'."
# fi
# }

restore () {
  if [[ "$1" == "omni" ]]; then
    tmux split-window -h -l 50 'docker compose up'
    tmux split-window -v 'cd packages/db && pnpm run db:studio --browser none'
    tmux last-pane
    pnpm run dev --filter @omni/internal "${@:2}"
  elif [[ "$1" == "hris" ]]; then
    tmux split-window -h -l 50 'docker compose up'
    tmux split-window -v 'pnpm db:studio -- --browser none'
    tmux last-pane
    pnpm run dev "${@:2}"
  elif [[ "$1" == "webservice" ]]; then
    current_dir=$(basename "$PWD")

    if [[ "$current_dir" == "fgi-web-service-backend" ]]; then
      tmux split-window -h -l 50 'docker compose up'
      tmux split-window -v 'cd ../fgi-web-service && npm run dev'
      tmux select-pane -t 1
      tmux send-keys 'pipenv run flask run' C-m
    elif [[ "$current_dir" == "webservice" ]]; then
      tmux split-window -h -l 50 'cd fgi-web-service-backend && docker compose up'
      tmux split-window -v 'cd fgi-web-service && npm run dev'
      tmux select-pane -t 1
      tmux send-keys 'cd fgi-web-service-backend && pipenv run flask run' C-m
    else
      echo "Not in a valid webservice directory. Must be 'webservice' or 'fgi-web-service-backend'."
    fi
  else
    echo "Invalid argument. Please provide 'omni' or 'webservice'."
  fi
}

# tms() {
#   # Define the base directories
#   local base_dirs=(~/Documents/Dev) #  ~/dotfiles
#
#   # Create an associative array to map base names to full paths
#   local -A repo_map
#
#   # Populate the repo_map with base names as keys and full paths as values
#   for dir in "${base_dirs[@]}"; do
#     for repo in "$dir"/*; do
#       if [[ -d $repo ]]; then
#         repo_map[$(basename "$repo")]="$repo"
#       fi
#     done
#   done
#
#   # Ensure fzf is installed
#   if ! command -v fzf > /dev/null; then
#     echo "fzf is not installed. Please install fzf to use this function."
#     return 1
#   fi
#
#   # If an argument is passed, use it as the selected repo
#   local selected_name
#   if [[ $# -eq 1 ]]; then
#     selected_name=$1
#   else
#     # Use fzf to select the repo base name
#     selected_name=$(echo ${(k)repo_map} | tr ' ' '\n' | fzf)
#   fi
#
#   # Exit if no selection is made
#   if [[ -z $selected_name ]]; then
#     return 0
#   fi
#
#   # Get the full path from the repo_map
#   local selected=${repo_map[$selected_name]}
#
#   # Replace dots with underscores for session name
#   local session_name=$(echo $selected_name | tr . _)
#   local tmux_running=$(pgrep tmux)
#
#   # Start a new session if no tmux server is running
#   if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
#     tmux new-session -s $session_name -c "$selected" && return 0
#   fi
#
#   # Check if the session already exists
#   if tmux has-session -t $session_name 2> /dev/null; then
#     # Switch to the existing session
#     if [[ -n $TMUX ]]; then
#       tmux switch-client -t $session_name
#     else
#       tmux attach-session -t $session_name
#     fi
#   else
#     # Create a new session if it doesn't exist
#     tmux new-session -ds $session_name -c "$selected" && tmux switch-client -t $session_name
#   fi
# }
# export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/justin.valencia/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
