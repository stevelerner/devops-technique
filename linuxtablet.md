### Creating an Ubuntu Linux Tablet

- Use a tablet that can run Windows 11
- Create a HD partition and format it as exFAT
- Install Ubuntu Server on that partition
- Boot into Ubuntu Server
- Edit the grub file to prevent it from having a black screen due to video driver issues
  ```
  sudo nano /etc/default/grub
  ```
  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
  ```
  - Install Ubuntu Desktop:
  ```
  sudo apt install ubuntu-desktop
  ```
- Reboot
  ```
  sudo reboot
  ```
- Fix login rotation: log in, fix rotation using display settings and then:
  ```
  sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
  ```
- Change network management from NetworkManager to Networkd:
  ```
  sudo cp -v /etc/netplan/01-netcfg.yaml ~
  sudo vi /etc/netplan/01-netcfg.yaml
  ```
  and change it to
  ```
  # Set and change netplan renderer to NetworkManager GUI tool 
  network:
    version: 2
    renderer: NetworkManager
  ```
  A reboot may be needed but GUI network management will now work
  
