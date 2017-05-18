# echo "keyring /etc/pacman.d/gnupg/pubring.gpg" >> ~/.gnupg/gpg.conf
sudo pacman-key -r $1
sudo pacman-key -f $1
sudo pacman-key --lsign-key $1
