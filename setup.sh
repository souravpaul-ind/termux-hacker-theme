#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 Installing Termux Hacker Theme..."
echo "-----------------------------------"

# 1. Install dependencies
pkg update -y && pkg upgrade -y
pkg install zsh git fzf cmatrix -y

# 2. Backup .zshrc (with Y/N prompt)
if [ -f ~/.zshrc ]; then
    read -p "⚠️  Do you want to backup your current .zshrc? (y/N): " backup_choice
    if [[ "$backup_choice" =~ ^[Yy]$ ]]; then
        cp ~/.zshrc ~/.zshrc.backup_$(date +%F_%H%M)
        echo "✅ Backup saved as ~/.zshrc.backup_$(date +%F_%H%M)"
    else
        echo "⏩ Skipping backup."
    fi
fi

# 3. Clone plugins
echo "📦 Cloning plugins..."
rm -rf ~/.zsh/zsh-autosuggestions ~/.zsh/zsh-syntax-highlighting
mkdir -p ~/.zsh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 2>/dev/null
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting 2>/dev/null

# 4. Disable default welcome message
touch ~/.hushlogin

# 5. Write new .zshrc
echo "📝 Writing ~/.zshrc..."
cat > ~/.zshrc << 'ZSH_EOF'
# ==========================================
# TERMUX ULTIMATE HACKER SETUP
# ==========================================
autoload -Uz colors && colors
setopt no_bang_hist
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS INC_APPEND_HISTORY

# Aliases
alias cls='clear'
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias q='exit'
alias update='pkg update && pkg upgrade -y'
alias install='pkg install -y'
alias search='pkg search'

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Tab Completion (Kali Style)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# Colors (Kali Style)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=magenta,bold'

# fzf (Ctrl+R)
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh 2>/dev/null) || {
    fzf-history-widget() {
      local selected
      selected=$(fc -rl 1 | fzf --height 40% --reverse +m) || return
      LBUFFER=$(echo "$selected" | sed 's/^ *[0-9]* *//')
      zle reset-prompt
    }
    zle -N fzf-history-widget
    bindkey '^R' fzf-history-widget
  }
fi

# Prompt
PS1=$'%{\e[1;32m%}┌──[%{\e[1;37m%}%n@%m%{\e[1;32m%}]─[%{\e[1;37m%}%~%{\e[1;32m%}]\n%{\e[1;32m%}└─$ %{\e[0m%}'

# Banner & Matrix
if [[ -o interactive ]]; then
  if command -v cmatrix >/dev/null 2>&1; then
    timeout 3.5 cmatrix -ab -C green -s
    clear
  fi
  G=$'\e[1;32m'; D=$'\e[0;32m'; R=$'\e[0m'; W=$'\e[1;37m'
  printf '\n'
  printf "${D}  ┌───────────────────────────────────────────┐${R}\n"
  printf "${D}  │${R}  ${G}▓▒░  T E R M U X  ░▒▓${R}                    ${D}│${R}\n"
  printf "${D}  │${R}  ─────────────────────────────────────    ${D}│${R}\n"
  printf "${D}  │${R}  ${D}>>${R} Android Linux Environment             ${D}│${R}\n"
  printf "${D}  │${R}  ${D}>>${R} Access Level : ${W}ROOTLESS${R}               ${D}│${R}\n"
  printf "${D}  │${R}  ${D}>>${R} Node         : ${W}$(hostname)${R}              ${D}│${R}\n"
  printf "${D}  └───────────────────────────────────────────┘${R}\n"
  printf '\n'
  printf "  ${G}[●]${R} SYSTEM ONLINE\n"
  printf "  ${G}[●]${R} SHELL LOADED\n"
  printf "  ${G}[●]${R} USER: ${W}$(whoami)${R}\n"
  printf '\n'
fi
ZSH_EOF

# 6. Set default shell
chsh -s zsh

echo "-----------------------------------"
echo "✅ Setup complete! Restart Termux now."
