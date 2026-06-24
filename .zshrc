# ╔══════════════════════════════════════════════════════════╗
# ║                JAMES' MODULAR ZSH CONFIG                 ║
# ║       Arch Linux • ROG SCAR 16 • Modular Bootloader      ║
# ╚══════════════════════════════════════════════════════════╝

# 1. Early Exit for non-interactive shells
[[ $- != *i* ]] && return

# 2. Core Zsh Modules
zmodload zsh/zle zsh/datetime zsh/stat

# 3. Terminal Behavior (Disable Ctrl-S/Ctrl-Q flow control)
stty -ixon

# ╔══════════════════════════════════════════════════════════╗
# ║                JAMES' MODULAR ZSH CONFIG                 ║
# ║       Arch Linux • ROG SCMA 16 • Modular Bootloader      ║
# ╚══════════════════════════════════════════════════════════╝

# 1. Early Exit for non-interactive shells
[[ $- != *i* ]] && return

# 2. Core Zsh Modules
zmodload zsh/zle
zmodload zsh/datetime
zmodload zsh/stat

# 3. Terminal Behavior (Disable Ctrl-S/Ctrl-Q flow control)
stty -ixon

# 4. Completion System Initialization (Optimized)
# Must happen BEFORE plugins that depend on compinit (like fzf-tab)
autoload -Uz compinit
() {
  local dump="$HOME/.cache/zcompdump"
  if zstat -H fstat "$dump" 2>/dev/null && (( EPOCHSECONDS - fstat[mtime] < 86400 )); then
    compinit -C -d "$dump"
  else
    compinit -d "$dump"; touch "$dump"
  fi
}

# 5. Load all modules from zshrc.d
for module in $HOME/.config/zsh/zshrc.d/*.zsh; do
    if [[ -f "$module" ]]; then
        source "$module"
    fi
done