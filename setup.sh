# install yay
git clone --depth=1 https://aur.archlinux.org/yay.git
cd yay
makepkg -si yay
cd ..
rm -rf yay

# install some wanted packages
yay -S $(cat packages.txt)

# change NetworkManager to use iwd
echo $'[device]\nwifi.backend=iwd' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf

# remove grub startup menu
sudo sed -i 's/GRUB_TIMEOUT=[1-9][1-9]*/GRUB_TIMEOUT=0\nGRUB_HIDDEN_TIMEOUT=0/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# rename Caprine to Messenger
sudo sed -i 's/Name=Caprine/Name=Messenger/' /usr/share/applications/caprine.desktop

# change some gnome settings
mv .config /home/ivan/

# disable systemd's mdns
sudo systemctl disable --now systemd-resolved

# enable avahi's mdns
sudo sed -i 's/hosts: mymachines/hosts: mymachines mds_minimal [NOTFOUND=return]/' /etc/nsswitch.conf
sudo systemctl enable --now avahi-daemon


# enable display manager
sudo systemctl enable --now gdm
