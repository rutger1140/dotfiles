# Add ~/bin to path
export PATH="$HOME/bin/$:$PATH"

# Go starship
eval "$(starship init zsh)"

#
# User configuration
#

# Default editor
export EDITOR="nvim"

# 
# Shortcuts
#

# Yarn
alias y="yarn"
alias yb="yarn build"
alias ys="yarn start"

# ZSH
alias ll="ls -alh"
alias la="ls -a"
alias l="ls -l"
alias lt="exa --tree --level=2"

# www shortcut
alias www="cd ~/web"

# neovim shortcut 
alias n="/usr/bin/nvim"

# git
alias g="git"

# Load FZF fuzzy seaching
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# MacOS
#
if [ "$(uname)" = "Darwin" ]; then
  # Set alias for neovim
  alias n="/opt/homebrew/bin/nvim"

  # Fix nvm path
  NVM_HOMEBREW=$(brew --prefix nvm)

  # Disable homebrew from updating other packages
  export HOMEBREW_NO_AUTO_UPDATE=1

  # Add nvm support
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

