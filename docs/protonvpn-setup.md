# Proton VPN setup (Omarchy / Arch)

Setup using wg-quick + WireGuard, no NetworkManager, no Proton daemon.

## Prerequisites

```bash
sudo pacman -S wireguard-tools gum
```

## Configs

Download WireGuard configs from https://account.protonvpn.com → Downloads → WireGuard.

Requirements:
- Filename under 15 chars, no dashes
- Naming convention: `proton<country>.conf` (e.g. `protonnl.conf`, `protonus.conf`)

Place in `/etc/wireguard/` with `chmod 600`:

```bash
sudo mv ~/Downloads/proton*.conf /etc/wireguard/
sudo chmod 600 /etc/wireguard/proton*.conf
```

Comment out the `DNS =` line in each config (Omarchy uses systemd-resolved,
adding openresolv just to handle this causes conflicts):

```bash
sudo sed -i 's/^DNS/#DNS/' /etc/wireguard/proton*.conf
```

## Passwordless sudo

Create `/etc/sudoers.d/wg-quick`:

```
<your-user> ALL=(root) NOPASSWD: /usr/bin/wg-quick, /usr/bin/ls /etc/wireguard, /usr/bin/ls /etc/wireguard/
```

```bash
sudo chmod 440 /etc/sudoers.d/wg-quick
```

## Scripts

- `fish/functions/vpn.fish` → symlink to `~/.config/fish/functions/vpn.fish`
- `bin/vpn-tui` → symlink to `~/.local/bin/vpn-tui` (chmod +x)

## Waybar module

Add to `~/.config/waybar/config`:

```jsonc
"custom/vpn": {
    "exec": "ip link show 2>/dev/null | grep -oE 'proton[a-z]+' | head -1 | sed 's/proton//' | grep . || echo off",
    "interval": 5,
    "format": "󰦝 {}",
    "tooltip-format": "Proton VPN — click to open menu",
    "on-click": "omarchy-launch-floating-terminal-with-presentation 'vpn-tui'"
}
```

## Usage

CLI:
```
vpn nl       # connect to NL
vpn us       # switch to US
vpn off      # disconnect
vpn status   # show current + IP
vpn list     # show available configs
```

TUI: click the waybar VPN icon, or run `vpn-tui` in a terminal.

## Adding new countries

1. Download `proton<xx>.conf` from Proton
2. `sudo mv ~/Downloads/proton<xx>.conf /etc/wireguard/`
3. `sudo chmod 600 /etc/wireguard/proton<xx>.conf`
4. `sudo sed -i 's/^DNS/#DNS/' /etc/wireguard/proton<xx>.conf`
5. Done — `vpn <xx>` works automatically
```
