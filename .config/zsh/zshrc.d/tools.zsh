# Tool Initializations

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v oh-my-posh >/dev/null && eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/sweet_sonicboom.omp.json")"
