# --- Shell Environment Initializations ---

# 1. Color Support (dircolors)
command -v dircolors >/dev/null 2>&1 && eval "$(dircolors -b)"

# 2. History Configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"

# History Options
setopt appendhistory 
setopt sharehistory 
setopt hist_ignore_space 
setopt hist_ignore_all_dups 
setopt hist_save_no_dups 
setopt hist_find_no_dups

# No bell
unsetopt beep
