# dot - manage dotfiles in a bare git repo at ~/.dotfiles
#
# Usage: dot [git arguments]
#   dot              show a short status of tracked dotfiles
#   dot add <file>   stage a dotfile
#   dot commit ...   any git command works, scoped to the dotfiles repo
#
# Run once after setup to hide untracked files in your home directory:
#   dot config status.showUntrackedFiles no
function dot --description "Manage dotfiles in bare git repo at ~/.dotfiles"
    if test (count $argv) -eq 0
        # No arguments: show a short status instead of git's usage text
        git --git-dir=$HOME/.dotfiles --work-tree=$HOME status -sb
    else
        git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
    end
end
