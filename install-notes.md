# Arch Install Notes
These are notes relating to installing arch

# Notes
## XOrg
Add `xsetroot -solid black` to `/etc/xprofile`.

## Packages
Create default pacman and aur package list to install.

## Networking
School wifi - annoying as FUCK
```sh
nmcli con add type wifi ifname wlp58s0 con-name SSID ssid SSID
nmcli con edit id SSID
set ipv4.method auto
set 802-1x.eap peap
set 802-1x.phase2-auth mschapv2
set 802-1x.identity USERNAME
set 802-1x.password PASSWORD
set wifi-sec.key-mgmt wpa-eap
save
active
quit
```
