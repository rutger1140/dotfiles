# Dotfiles 

Dotfiles setup using [bare git](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git) method.

## Init
```shell
git init --bare ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles config status.showUntrackedFiles no
```

## Replicate on other system
```shell
git clone --bare <git-repo-url> $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

# Setup dev languages with Mise
```shell
mise plugins install php
mise use --global php@8.3
mise use --global ruby@3.3
mise use --global node@20
```

# Ubuntu install script

Start with:

```shell
bash <(wget -qO- https://raw.githubusercontent.com/rutger1140/dotfiles/main/scripts/install.sh)
```
