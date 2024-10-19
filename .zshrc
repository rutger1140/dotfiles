#
# User configuration
#

# Default editor
export EDITOR="nvim"

# Add bin to path
export PATH="$HOME/bin/:$HOME/.local/bin/:$HOME/.lando/bin:$PATH"

###########
# Aliases #
###########

# File system
alias ls='eza -lh --group-directories-first --icons'
alias ll='ls -alh'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'
alias cd='z'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias g='git'
alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'

# Yarn
alias y="yarn"
alias yb="yarn build"
alias ys="yarn start"

# Dotfiles management
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

########
# Init #
########

# Go Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Prepare mise-en-place
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Setup Zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Setup fzf
if command -v fzf &> /dev/null; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

