#!/bin/ash

apk add curl socat nmap net-tools build-base setxkbmap sudo xrandr bash zsh dbus dbus-x11 sudo setup-xorg-base xfce4 xfce4-terminal lightdm dbus-x11
apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk
apk add lightdm-gtk-greeter i3wm i3status libxcb-dev i3lock xf86-video-vmware dmenu
apk add mesa-gl glib feh firefox-esr accountsservice openvpn
apk add docker docker-compose

# add user
adduser milian
mkdir -p /home/milian/wallpaper
mkdir -p /home/milian/.config/i3

# user setup milian
cp ./milian/wallpaper/30.jpg /home/milian/wallpaper/30.jpg
cp ./milian/.config/i3/config /home/milian/.config/i3/config
#cp ./milian/.profile /home/milian/.profile
mkdir -p /home/milian/.scripts
cp ./milian/login-script.sh /home/milian/.scripts/login-script.sh
chown -R milian:milian /home/milian

# add milian to sudoers
cat ./milian/sudoers >> /etc/sudoers

# greeter background
echo "background=/home/milian/wallpaper/30.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./milian/milian /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/milian

# add user to docker
addgroup milian docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# give milian write access to /opt dir
chown milian:milian /opt

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown milian:milian /opt/docker


