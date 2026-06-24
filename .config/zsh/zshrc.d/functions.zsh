# Safety Tools: rm wrapper
rm() {
  for arg in "$@"; do
    [[ "$arg" == -* ]] && continue
    local resolved=$(realpath -m "$arg" 2>/dev/null || echo "$arg")
    if [[ "$resolved" == "/" || "$resolved" == "$HOME" ]]; then
      print -P "\n%F{red}%BBlocked:%b Refusing to rm $resolved."; return 1
    fi
    for critical in /boot /etc /usr /lib /etc /bin /sbin /var /proc /sys /dev; do
      if [[ "$resolved" == "$critical"* ]]; then
        print -P "\n%F{red}%BBlocked:%b Refusing to rm $resolved."; return 1
      fi
    done
  done
  command rm "$@"
}

# Fancy Ctrl-Z
fancy-ctrl-z() { [[ -z $BUFFER ]] && fg 2>/dev/null || { zle push-input; zle accept-line; } }
zle -N fancy-ctrl-z; bindkey '^Z' fancy-ctrl-z

# Sudo Toggle (ESC ESC)
sudo-toggle() {
  local cmd="${BUFFER:-$(fc -ln -1 | sed 's/^[ \t]*//')}"
  [[ -z $cmd ]] && return
  [[ $cmd == sudo\ * ]] && BUFFER="${cmd#sudo }" || BUFFER="sudo $cmd"
  CURSOR=${#BUFFER}
}
zle -N sudo-toggle
bindkey -M emacs '^S' sudo-toggle; bindkey -M vicmd '^S' sudo-toggle; bindkey -M viins '^S' sudo-toggle

# Command Not Found Handler
command_not_found_handler() {
  local cmd="$1"
  print -P "%F{yellow}Command not found:%f $cmd"
  local repo_pkg=$(pacman -Fq "/usr/bin/$cmd" 2>/dev/null | head -n 1)
  if [[ -n "$repo_pkg" ]]; then
    print -P "%F{green}Found:%f $repo_pkg. Install with: sudo pacman -S $repo_pkg"
  else
    print -P "%F{red}Not found in repos. Try AUR:%f paru -Ssq $cmd"
  fi
  return 127
}

# Helpers & Functions
cleanup() {
  print "🧹 Initiating cleanup protocol, sir!"
  sudo pacman -Sc --noconfirm
  sudo rm -f -r /var/cache/pacman/pkg/download-*
  local orphans=$(pacman -Qtdq 2>/dev/null)
  if [[ -n $orphans ]]; then
    print -P "%F{yellow}⚠️  Orphans detected:%f\n$orphans"
    print -P "%F{cyan}Proceed? [y/N]%f" && read -r confirm
    [[ "$confirm" =~ ^[Yy]$ ]] && { echo "$orphans" | sudo pacman -Rns -; print -P "%F{green}✅ Neutralized.%f"; } || print "👮‍♂️ Aborted."
  else
    print -P "%F{green}✅ No orphans. System clean.%f"
  fi
}

paruedit() {
  [[ -z "$1" ]] && { print "Usage: paruedit <package>"; return 1; }
  paru -S "$1" --fm nvim
}

sudo() {
  case "$1" in
    nvim|vim|vi|nano) local editor="$1"; shift; SUDO_EDITOR="$editor" sudoedit "$@" ;;
    *) command sudo "$@" ;;
  esac
}

sysinfo() {
  print -P "\n%F{cyan}=== SYSTEM HEALTH ===%f"
  cpu
  print -P "\n%F{cyan}=== GPU STATUS ===%s"
  gpu
  print -P "\n%F{cyan}=== MEMORY USAGE ===%f"
  mem
  print -P "\n%F{cyan}====================%f"
}


# Fast fzf file searcher (Simple Mode)
# Features: Tab/Shift-Tab navigation, Clean paths, Auto-CD to selected item or its parent
f() {
    local search_path="${1:-.}"
    local tmp_file=$(mktemp)
    local selection
    local abs_search_path

    if [[ ! -d "$search_path" ]]; then
        echo "Error: Directory '$search_path' does not exist."
        return 1
    fi

    # Get the absolute path to use for the truncation logic
    abs_search_path=$(realpath "$search_path")

    # 1. Run fd (searching everything '.')
    # 2. Use awk to create "Full/Path|Relative/Path" format
    # 3. Store in tmp_file
    if sudo fd . --hidden \
        --exclude '.snapshots' \
        "$search_path" 2>/dev/null | \
        awk -v p="$abs_search_path" '{ 
            rel=$0; 
            sub(p "/", "", rel); 
            print $0 "|" rel 
        }' > "$tmp_file"; then

        # Check if any files were actually found
        if [[ ! -s "$tmp_file" ]]; then
            echo "No files found in '$search_path'."
            rm -f "$tmp_file"
            return 0
        fi

        # Run fzf with custom keybindings and capture selection
        selection=$(fzf --delimiter '|' \
                        --with-nth 2 \
                        --bind 'tab:up,shift-tab:down' \
                        --preview "/home/$USER/.local/bin/fzf-preview {1}" < "$tmp_file")

        # If a selection was made, process the path
        if [[ -n "$selection" ]]; then
            local full_path=$(echo "$selection" | cut -d'|' -f1)
            
            if [[ -d "$full_path" ]]; then
                # If the selected item IS a directory, cd straight into it
                cd "$full_path" || return 1
            else
                # If the selected item is a file, cd into its parent directory
                local target_dir=$(dirname "$full_path")
                cd "$target_dir" || return 1
            fi
        fi
    else
        echo "Authentication failed or search error occurred."
    fi

    rm -f "$tmp_file"
}

