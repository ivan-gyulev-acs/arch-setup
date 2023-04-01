# install yay
git clone --depth=1 https://aur.archlinux.org/yay.git
cd yay
makepkg -si yay
cd ..
rm -rf yay

# install some wanted packages
yay -S $(cat packages.txt)

# set iwd as NetworkManager's backend
echo $'[device]\nwifi.backend=iwd' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
sudo systemctl restart NetworkManager

# remove grub startup menu
sudo sed -i 's/GRUB_TIMEOUT=[1-9][1-9]*/GRUB_TIMEOUT=0\nGRUB_HIDDEN_TIMEOUT=0/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# rename Caprine to Messenger
sudo sed -i 's/Name=Caprine/Name=Messenger/' /usr/share/applications/caprine.desktop

# change some gnome settings
cp .config /home/ivan/

# enable mdns
sudo sed -i 's/hosts: mymachines/hosts: mymachines mds_minimal [NOTFOUND=return]/' /etc/nsswitch.conf

# enable display manager
sudo systemctl enable --now gdm
