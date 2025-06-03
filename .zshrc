export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Set your preferred theme
ZSH_THEME="robbyrussell"  # You can switch to "agnoster", "bira", or "powerlevel10k" if installed

# Plugins
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


KITTY_ENABLE_WAYLAND=1 zellij


# Starship prompt
eval "$(starship init zsh)"

# Bun setup
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# General PATH additions (add more as needed)
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias l='ls -lah'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias nv='nvim'
alias update='sudo pacman -Syu && yay -Syu'

# Terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# History settings
export HISTSIZE=5000
export SAVEHIST=5000
setopt hist_ignore_dups
setopt share_history

# Syntax highlighting settings
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Disable "last login" message
touch ~/.hushlogin

