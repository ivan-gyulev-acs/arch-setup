# install yay
git clone --depth=1 https://aur.archlinux.org/yay.git
cd yay
makepkg -i yay
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

# enable important services
sudo systemctl enable NetworkManager
sudo systemctl enable iwd
sudo systemctl enable avahi-daemon
sudo systemctl enable gdm
