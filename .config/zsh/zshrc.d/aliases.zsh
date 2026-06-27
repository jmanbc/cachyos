# Git Shorthands
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --online --graph --decorate'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Utilities
alias cat='bat'
alias realcat='command cat' 
alias q='exit'
alias wget='wget -c' 
alias df='df -hT'
alias grep='grep --color=auto'

# System
alias cpu='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
alias gpu='nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader'
alias mem='ps axch -o cmd:15,%mem --sort=-%mem | head'
alias jctl='journalctl -p warning -S "24 hours ago"' 
alias netdebug='sudo ss -tulpn'

# Arch/Pacman (Riplat)
alias riplatest='expac --timefmt='\''%Y-%m/d %T'\'' '\''%l\t%n %v'\'' | sort | tail -100 | nl'
alias ripall='expac --timefmt='\''%Y-%m/d %T'\'' '\''%l\t%n %v'\'' | sort | nl'

# Steam/Gaming
alias steamhdr='gamescope -W 3440 -H 1440 -r 165 -f -e --hdr-enabled --force-grab-cursor --mangoapp -- steam -steamos3'

# File Listing (Eza)
alias lsa='eza -lahF --color=always --icons --sort=size --group-directories-first'
alias ls='eza -lhF --color=always --icons --sort=size --group-directories-first'
alias lst='eza -lahfT --color=always --icons --sort=size --group-directories-first'

# Zoxide Integration
command -v zoxide >/dev/null 2>&1 && alias cd='z'
