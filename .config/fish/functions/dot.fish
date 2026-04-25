function dot --description "Manage dotfiles in bare git repo at ~/.dotfiles"
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
