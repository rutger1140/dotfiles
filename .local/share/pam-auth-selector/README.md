# PAM Authentication Selector

Smart PAM authentication switching based on laptop lid state for Ubuntu systems. Automatically chooses between fingerprint reader (laptop open) and Yubikey (clamshell mode) authentication methods.

## Features

- **Automatic detection**: Switches between authentication methods based on laptop lid state
- **Fingerprint + Password**: When laptop is open, uses fingerprint reader with fallback to password
- **Yubikey + Password**: When laptop is closed (clamshell mode), uses Yubikey with fallback to password
- **Manual override**: Force specific authentication modes when needed
- **1Password integration**: Works with 1Password system authentication prompts
- **Dotfiles friendly**: All files can be version controlled and easily deployed

## File Structure

```
~/.local/share/pam-auth-selector/
├── bin/
│   ├── pam-auth-selector       # Main authentication selector script
│   └── install                 # System integration installer
├── templates/
│   ├── pam-lid-detector.service    # Systemd service template
│   └── 99-pam-lid-detector.rules   # Udev rules template
├── test/                       # Test configurations (created when testing)
└── README.md                   # This file
```

## Prerequisites

### Required packages
```bash
# Fingerprint support
sudo apt install fprintd libpam-fprintd

# Yubikey U2F support  
sudo apt install libpam-u2f
```

### Setup fingerprints
```bash
# Enroll your fingerprints
fprintd-enroll

# Verify enrollment
fprintd-list
```

### Configure Yubikey
```bash
# Create Yubikey U2F configuration
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys

# Alternative: system-wide configuration
sudo mkdir -p /etc/Yubico
sudo pamu2fcfg -u $(whoami) | sudo tee /etc/Yubico/u2f_keys
```

## Installation

### 1. Install in dotfiles
Place the entire `pam-auth-selector` directory in your dotfiles:
```bash
# In your dotfiles repo
~/.local/share/pam-auth-selector/
```

### 2. Add to PATH (optional but recommended)
```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$HOME/.local/share/pam-auth-selector/bin:$PATH"

# Or create symlinks
ln -sf ~/.local/share/pam-auth-selector/bin/pam-auth-selector ~/.local/bin/
ln -sf ~/.local/share/pam-auth-selector/bin/install ~/.local/bin/pam-auth-install
```

### 3. Install system integration
```bash
# From within the pam-auth-selector directory
cd ~/.local/share/pam-auth-selector
./bin/install install

# Or if added to PATH
install install

# Check installation status
install status
```

### 4. Activate PAM configuration
```bash
# Test first (creates test config in ./test/)
pam-auth-selector auto

# Review test configuration
cat ~/.local/share/pam-auth-selector/test/common-auth

# Apply to system (requires sudo)
sudo pam-auth-selector auto
```

## Usage

### Automatic Mode (Recommended)
The system automatically detects lid state and switches authentication methods:

- **Laptop open**: Fingerprint reader → Password fallback
- **Laptop closed**: Yubikey → Password fallback

### Manual Override
Force specific authentication modes when needed:

```bash
# Force fingerprint mode (laptop open)
sudo pam-auth-selector open

# Force Yubikey mode (laptop closed)  
sudo pam-auth-selector closed

# Auto-detect mode (default)
sudo pam-auth-selector auto
```

### Testing
Test configuration without modifying system files:
```bash
# Creates test config in ./test/
pam-auth-selector auto

# Review generated configuration
cat ~/.local/share/pam-auth-selector/test/common-auth
```

## Management Commands

### Installation management
```bash
install install      # Install system integration
install uninstall    # Remove system integration  
install reinstall    # Reinstall (uninstall + install)
install status       # Check installation status
```

### Check current configuration
```bash
# View current PAM configuration
cat /etc/pam.d/common-auth

# View backup configurations
ls -la /etc/pam.d/backup/
```

## How It Works

### Detection Logic
The script detects laptop lid state using multiple methods:

1. **ACPI lid state**: Checks `/proc/acpi/button/lid/*/state`
2. **Display detection**: Falls back to checking if built-in displays (eDP/LVDS) are active
3. **Default assumption**: If detection fails, assumes laptop is closed (safer for clamshell mode)

### PAM Configuration

**Open laptop configuration:**
```
auth [success=3 default=ignore] pam_fprintd.so timeout=5
auth [success=2 default=ignore] pam_unix.so nullok  
auth [success=1 default=ignore] pam_sss.so use_first_pass
```

**Closed laptop configuration:**
```
auth sufficient                 pam_u2f.so cue
auth [success=2 default=ignore] pam_unix.so nullok
auth [success=1 default=ignore] pam_sss.so use_first_pass  
```

### Automatic Triggers
System integration uses:

- **Systemd service**: Runs authentication selector on system events
- **Udev rules**: Triggers on lid state changes, ACPI events, and display connection changes

## Troubleshooting

### Check system status
```bash
# Verify all components are installed
install status

# Check systemd service
sudo systemctl status pam-lid-detector.service

# Check udev rules
cat /etc/udev/rules.d/99-pam-lid-detector.rules
```

### Test lid detection
```bash
# Test lid detection manually
pam-auth-selector auto

# Check what configuration would be applied
cat ~/.local/share/pam-auth-selector/test/common-auth
```

### Authentication issues

**Fingerprint not working:**
```bash
# Check fingerprint enrollment
fprintd-list

# Test fingerprint reader
fprintd-verify

# Re-enroll if needed
fprintd-delete $(whoami)
fprintd-enroll
```

**Yubikey not working:**
```bash
# Test Yubikey detection
lsusb | grep Yubico

# Verify U2F configuration
cat ~/.config/Yubico/u2f_keys

# Test with pamu2fcfg
pamu2fcfg -v
```

**1Password hanging on fingerprint:**
- This is a known issue with some GUI applications
- The automatic switching should resolve this by using appropriate timeouts
- You can manually switch modes if needed

### Recovery
If authentication stops working:

```bash
# Restore previous PAM configuration
sudo cp /etc/pam.d/backup/common-auth.YYYYMMDD_HHMMSS /etc/pam.d/common-auth

# Or reset to default Ubuntu configuration
sudo pam-auth-update --force
```

## Configuration Files

### Backup Location
All PAM configuration changes are automatically backed up to:
```
/etc/pam.d/backup/common-auth.YYYYMMDD_HHMMSS
```

### Template Variables
System integration templates use these variables:
- `{{HOME}}`: Replaced with user's home directory path

## Security Notes

- Authentication always falls back to password if biometric/hardware methods fail
- Original PAM configurations are backed up before modification
- System integration requires root privileges (sudo) for installation
- All authentication methods can be manually overridden if needed

## Compatibility

- **Tested on**: Ubuntu 20.04, 22.04, 24.04
- **Requirements**: systemd, udev, PAM
- **Hardware**: Any laptop with fingerprint reader, Yubikey 4/5 with U2F support
- **Desktop environments**: Works with GNOME, KDE, XFCE, and others

## Contributing

This is part of a personal dotfiles setup. Feel free to adapt the scripts for your own use case.

### Development
```bash
# Test mode for development
pam-auth-selector auto  # Creates test configs in ~/.local/share/pam-test/

# Apply changes  
sudo pam-auth-selector auto
```
