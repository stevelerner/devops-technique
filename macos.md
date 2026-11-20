# macOS Cheat Sheet

## Disk Management
**Image a USB drive to .dmg file:**  
1. List disks:
   ```bash
   diskutil list
   ```
2. Create image (replace `rdisk4` with your disk):
   ```bash
   sudo dd if=/dev/rdisk4 of=sd_backup.dmg bs=16m
   ```

**Totally erase disk so it can be partitioned with APFS:**
```bash
diskutil partitionDisk disk4 GPT %APSFX% foo 0
```

**Zap all partitions to blank (no partition scheme at all), then reformat as exFAT:**  
Useful for wiping a SD card / USB drive that has a foreign partition table (e.g. Batocera, Raspberry Pi OS) that `diskutil eraseDisk` won't cleanly remove.
1. Unmount and zero out the partition table / boot sectors (replace `disk4`/`rdisk4` with your disk):
   ```bash
   diskutil unmountDisk /dev/disk4
   sudo dd if=/dev/zero of=/dev/rdisk4 bs=1m count=10
   ```
   `diskutil list disk4` should now show no partitions, just the raw disk.
2. Partition as a single exFAT volume with a GPT scheme:
   ```bash
   diskutil eraseDisk ExFAT SDCARD GPT /dev/disk4
   ```

## Shell

**Make sure macOS uses bash:**
1. Check the current login shell:
   ```bash
   echo $SHELL
   dscl . -read /Users/$USER UserShell
   ```
2. Switch to bash if it isn't (`/bin/bash` is Apple's built-in 3.2; use `/opt/homebrew/bin/bash` for a newer one, after adding it to `/etc/shells`):
   ```bash
   chsh -s /bin/bash
   ```
3. Open a new terminal window. Silence the "default shell is now zsh" notice:
   ```bash
   echo 'export BASH_SILENCE_DEPRECATION_WARNING=1' >> ~/.bash_profile
   ```

Bash login shells (Terminal.app, iTerm) read `~/.bash_profile`, not `~/.zshrc`. Put aliases and exports there.
