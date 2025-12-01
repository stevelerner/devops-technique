# Creating an Ubuntu Linux Tablet

- Use a tablet that can run Windows 11
- Create a HD partition and format it as exFAT
- Install Ubuntu Server on that partition
- Boot into Ubuntu Server

## Configuration
**Edit the grub file to prevent black screen (video driver issues):**
```bash
sudo nano /etc/default/grub
```
Change line to:
```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
```

**Install Ubuntu Desktop:**
```bash
sudo apt install ubuntu-desktop
```

**Reboot:**
```bash
sudo reboot
```

## Post-Install Fixes
**Fix login rotation:**
Log in, fix rotation using display settings and then:
```bash
sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
```

**Change network management from NetworkManager to Networkd:**
```bash
sudo cp -v /etc/netplan/01-netcfg.yaml ~
sudo vi /etc/netplan/01-netcfg.yaml
```
Change it to:
```yaml
# Set and change netplan renderer to NetworkManager GUI tool 
network:
  version: 2
  renderer: NetworkManager
```
A reboot may be needed but GUI network management will now work.
  
