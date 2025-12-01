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
