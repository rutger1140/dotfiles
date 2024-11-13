#
# User configuration
#

# Oh My Zsh 
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Default editor
export EDITOR="nvim"

# Add bin to path
export PATH="$HOME/bin/:$HOME/.local/bin/:$HOME/.lando/bin:$HOME/.tmuxifier/bin:$PATH"

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
alias tmf='tmuxifier'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias vim='nvim'
alias g='git'
alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'
alias sail='./vendor/bin/sail'

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

# # Setup tmux on start if not in a tmux session
# if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
#   tmux attach || tmux new
# fi

# Setup tmuxifier
if command -v tmuxifier &> /dev/null; then
 eval "$(tmuxifier init -)"
fi

# Setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

