# Dotfiles

Personal dotfiles for Arch Linux + [Omarchy](https://omarchy.org/), tracked with [bare git](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git).

## What's tracked

- `.gitconfig` — personal git settings (1Password SSH signing, aliases). Layers on top of Omarchy's stock `~/.config/git/config`.
- `.gitignore_global` — wired in via `core.excludesfile`.
- `.config/tmux/tmux.conf` — leader Ctrl-S, vim-keys, Catppuccin-flavoured status bar.
- `.config/alacritty/alacritty.toml` — MonoLisa Variable, size 10.
- `.config/hypr/{input,bindings,monitors,looknfeel,autostart}.conf` — personal Hyprland configs.
- `.config/fish/config.fish` and `.config/fish/functions/{dot,dcomposer}.fish`.
- `.local/share/fonts/MonoLisaVariable*.ttf` — paid font.

## Bootstrap on a fresh Arch + Omarchy install

```fish
# 1. Apply the theme (rounded borders, pill waybar, slide animations)
omarchy-theme-install https://github.com/rutger1140/omarchy-mochajuice-theme

# 2. Install the fish package (interactive shell; system stays bash)
omarchy-pkg-install omarchy-fish

# 3. Bootstrap dotfiles
git clone --bare https://github.com/rutger1140/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout main

# 4. Refresh font cache so MonoLisa is picked up
fc-cache -f ~/.local/share/fonts/
```

Step 3 may complain about overwriting existing files. Either back them up first or use `checkout -f` if you're sure.

After bootstrap, the `dot` fish function is available:

```fish
dot status
dot add ~/.config/some/file
dot commit -m "..."
dot push
```

## Branches

- `main` — Arch + Omarchy (current).
- `ubuntu` — preserved old Ubuntu setup, no longer maintained.

## Related

- Theme: [rutger1140/omarchy-mochajuice-theme](https://github.com/rutger1140/omarchy-mochajuice-theme)
