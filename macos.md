image a USB drive to .dmg file:  

`diskutil list`

`sudo gdd if=/dev/rdisk4 of=sd_backup.dmg status=progress bs=16M`  
where rdisk4 replaced with disk to be imaged
