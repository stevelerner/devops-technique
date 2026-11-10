# Ubuntu Cheat Sheet

**Update and upgrade (update first):**
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install <package_name>
```

**Install a .deb, then fix missing dependencies:**
```bash
sudo dpkg -i package.deb
sudo apt -f install
```
