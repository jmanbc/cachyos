# --- XDG Base Directory Specification ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# --- Locale Standardization ---
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# --- Path Management ---
typeset -U path
path=($HOME/.local/bin /opt/cuda/bin $path)

# --- Environment Variables ---
export LD_LIBRARY_PATH=/opt/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export CUDA_PATH=/opt/cuda CUDA_HOME=/opt/cuda
export EDITOR=nvim VISUAL=nvim SYSTEMD_EDITOR=nvim

# Sweet KDE Colors for LS_COLORS (used by ls, eza, etc.)
export LS_COLORS="di=36:ln=35:so=35:pi=33:bd=34:cd=34:su=31:sg=32:ow=33:st=37:ex=32"

export MANPAGER='sh -c "col -bx | bat -l man -p --paging=always"'
export PAGER="less -R"

export KITTY_SHELL_INTEGRATION=enabled

