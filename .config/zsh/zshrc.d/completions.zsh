setopt GLOB_DOTS

# FZF Default Options (Sweet Theme)
export FZF_DEFAULT_OPTS="--style full --height 95% --color=border:35,fg:7,fg+:35,hl:35,info:36,prompt:35,spinner:35,pointer:35,label:35"

# FZF CTRL-R Options
export FZF_CTRL_R_OPTS="--bind='tab:up,shift-tab:down'"

# Completion System Configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' descriptions format '[%d]'
zstyle ':completion:*' list-args true
zymmetric_colors=('${(s.:.)LS_COLORS}') # just a placeholder for structure
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} menu select use-cache on cache-path "$HOME/.cache/zcompcache"
zstyle ':completion:*' menu no

# --- FZF-TAB INTEGRATION ---

# 1. The Catch-All: Everything uses the custom preview script by default
zstyle ':fzf-tab:complete:*:*' fzf-preview "$HOME/.local/bin/fzf-preview \${(Q)realpath}"

# 2. Specialized Overrides (Optimized for speed and context)
# Directories: Use eza for a clean, icon-rich list
zstyle ':fzf-tab:complete:(cd|z|__zoxide_z):*' fzf-preview 'eza -1 --color=always --icons $realpath'

# Git: Use delta for beautiful diffs and logs
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'case "$group" in "commit tag") git show --color=always $word ;; *) git show --color=always $word | delta ;; esac'

# 3. UI/UX Configuration
#zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-pad '2'
zstyle ':fzf-tab:*' async select
zstyle ':fzf-tab:*' fzf-min-height 100
