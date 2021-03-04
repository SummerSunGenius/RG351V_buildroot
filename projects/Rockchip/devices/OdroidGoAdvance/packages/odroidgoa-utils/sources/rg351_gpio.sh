#!/bin/bash
. /etc/profile

if [ ! -d "/sys/class/gpio/gpio64" ]; then
  echo 64 > /sys/class/gpio/export
fi
if [ ! -d "/sys/class/gpio/gpio65" ]; then
  echo 65 > /sys/class/gpio/export
fi
Keyvolup_down=0
Keyvoldown_down=0
Sdcard_in=0
Sdcard_out=0
while(true)
do
GPIO64=$(cat /sys/class/gpio/gpio64/value)
GPIO65=$(cat /sys/class/gpio/gpio65/value)
[[ "$GPIO64" == "0" ]] && Keyvolup_down=1
[[ "$GPIO64" == "1" ]] && [[ "$Keyvolup_down" == "1" ]] && /emuelec/scripts/odroidgoa_utils.sh vol + && Keyvolup_down=0
[[ "$GPIO65" == "0" ]] && Keyvoldown_down=1
[[ "$GPIO65" == "1" ]] && [[ "$Keyvoldown_down" == "1" ]] && /emuelec/scripts/odroidgoa_utils.sh vol - && Keyvoldown_down=0
[[ ! -b "/dev/mmcblk1p1" ]] && Sdcard_in=1
#[[ -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_in" == "1" ]] && umount /var/media/GAMES
#[[ -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_in" == "1" ]] && umount /storage/roms
#[[ -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_in" == "1" ]] && umount /dev/mmcblk1p1
#[[ -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_in" == "1" ]] && mount -o umask=000 -t vfat /dev/mmcblk1p1 /storage/roms && Sdcard_in=0
if [[ -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_in" == "1" ]]; then
umount /var/media/GAMES
umount /storage/roms
umount /dev/mmcblk1p1
mount -o umask=000 -t vfat /dev/mmcblk1p1 /storage/roms
systemctl restart emustation
Sdcard_in=0
Sdcard_out=1
fi
if [[ ! -b "/dev/mmcblk1p1" ]] && [[ "$Sdcard_out" == "1" ]]; then
umount /var/media/GAMES
umount /storage/roms
mount -o umask=000 -t vfat /dev/mmcblk0p3 /storage/roms
systemctl restart emustation
Sdcard_out=0
fi
done
