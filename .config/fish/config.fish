# ~/.config/fish/config.fish

# Add fish greeting with fastfetch
function fish_greeting
  fastfetch
end

# Default editor
set -x EDITOR nvim

# Add bin to path
set -U fish_user_paths $HOME/bin $HOME/.local/bin $HOME/.lando/bin $HOME/.tmuxifier/bin $fish_user_paths

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
#alias cd z
alias tmf tmuxifier

# Directories
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

# Tools
alias n nvim
alias vim nvim
alias g git
alias bat batcat
alias lzg lazygit
alias lzd lazydocker
alias sail "./vendor/bin/sail"

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

# Link cd to z
function cd
    if test (count $argv) -eq 0
        z
    else
        z $argv
    end
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

