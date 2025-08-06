# ~/.config/fish/config.fish

# Add fish greeting with fastfetch
function fish_greeting
  # fastfetch
end

# Default editor
set -x EDITOR nvim

# Note CLI 
set -Ux NOTE_DIR "$HOME/Stack/Notes"
set -Ux NOTE_EDITOR "nvim -c \"Neotree filesystem left dir=\$NOTE_DIR\" -c \"wincmd l\""

# Add bin to path
set -U fish_user_paths $HOME/bin $HOME/.local/bin $HOME/.lando/bin $HOME/.tmuxifier/bin $HOME/.local/share/pam-auth-selector/bin $fish_user_paths

###########
# Aliases #
###########

# File system
alias ls "eza -lh --group-directories-first --icons"
alias ll "ls -alh"
alias lsa "ls -a"
alias lt "eza --tree --level=2 --long --icons --git"
alias lta "lt -a"
alias ff "fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd fdfind
alias tmf tmuxifier

# Directories
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

# Tools
alias n nvim
alias g git
alias bat "batcat --style=numbers --color=always"
alias lzg lazygit
alias lzd lazydocker

# Note.sh extra shortcuts
alias nn "note new"
alias nl "note list"
alias ne "note edit"
alias ng "note grep"

# Yarn
alias y yarn
alias yb "yarn build"
alias ys "yarn start"

# Dotfiles management
alias dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lzgd "lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

########
# Init #
########

# Go Starship
if type -q starship
    starship init fish | source
end

# Prepare mise-en-place
if type -q mise
    mise activate fish | source
end

# Setup Zoxide
if type -q zoxide
    zoxide init fish | source
end

# Setup tmuxifier
if type -q tmuxifier
  eval (tmuxifier init -)
end

# Setup fzf
if command -v fzf > /dev/null 
  fzf --fish | source
end

# convert webm2mp4 
function webm2mp4
  set input_file $argv[1]
  set output_file (string replace .webm .mp4 $input_file)
  ffmpeg -i "$input_file" -vf "scale='trunc(iw/2)*2:trunc(ih/2)*2'" -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 192k "$output_file"
end

