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

**Install and switch to modern Bash (Homebrew):**  
macOS ships with an outdated Bash (v3.2) due to licensing. To install the latest Bash version and set it as your default login shell:

1. Install modern Bash:
   ```bash
   brew install bash
   ```
2. Add Homebrew's Bash path to allowed login shells in `/private/etc/shells`:
   ```bash
   echo $(brew --prefix)/bin/bash | sudo tee -a /private/etc/shells
   ```
3. Change default login shell to Homebrew Bash:
   ```bash
   chsh -s $(brew --prefix)/bin/bash
   ```
4. Verify shell and version:
   ```bash
   echo $SHELL
   bash --version
   ```
5. Open a new terminal window. Silence the "default shell is now zsh" notice:
   ```bash
   echo 'export BASH_SILENCE_DEPRECATION_WARNING=1' >> ~/.bash_profile
   ```

Bash login shells (Terminal.app, iTerm) read `~/.bash_profile`, not `~/.zshrc`. Put aliases and exports there.
