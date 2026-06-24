# Keybindings

# History Search
bindkey '^R' history-incremental-search-backward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Enable Vi Mode
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Navigation & Editing
bindkey '^A' beginning-of-line '^E' end-of-line '^H' backward-kill-word
bindkey '^[[3;5~' kill-word '^[.' insert-last-word

# Autosuggestions Accept (Ctrl-F)
bindkey '^F' autosuggest-accept

# ZLE Fixes/Customizations
zle -N zle-line-init; zle-line-init() { print -n '\e[5 q'; }

# --- KEYBINDINGS & VI MODE ---
bindkey -v

# Fix Backspace in Vi Mode
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# --- CLIPBOARD UTILITIES (SILENT) ---

# 1. Copy function (Silent)
copy-line-to-clipboard() {
    echo -n "$BUFFER" | wl-copy
    zle reset-prompt
}
zle -N copy-line-to-clipboard

# 2. Cut function (Silent)
cut-line-to-clipboard() {
    echo -n "$BUFFER" | wl-copy
    BUFFER=""
    zle reset-prompt
}
zle -N cut-line-to-clipboard

# --- BINDINGS ---
bindkey -M vicmd 'y' copy-line-to-clipboard
bindkey -M viins 'y' copy-line-to-clipboard
bindkey -M vicmd 'x' cut-line-to-clipboard
bindkey -M viins 'x' cut-line-to-clipboard
