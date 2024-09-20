# Add ~/bin to path
export PATH="$HOME/bin/$:$PATH"

# Fix nvm path
NVM_HOMEBREW=$(brew --prefix nvm)

# Go starship
eval "$(starship init zsh)"

# User configuration

# Default editor
export EDITOR="nvim"

# Yarn
alias y="yarn"
alias yb="yarn build"
alias ys="yarn start"

# www shortcut
alias www="cd ~/web"

# neovim shortcut - @TODO: fix for cross platfom
alias n="/opt/homebrew/bin/nvim"

# Disable homebrew from updating other packages
export HOMEBREW_NO_AUTO_UPDATE=1

# Add nvm support
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Load FZF fuzzy seaching
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

