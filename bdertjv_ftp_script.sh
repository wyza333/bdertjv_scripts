#!/bin/bash

# Met à jour le système et installe les paquets
sudo apt update && sudo apt upgrade -y
sudo apt install vsftpd -y

# Modifie les paramètres dans vsftpd.conf
sudo sed -i 's/#write_enable=YES/write_enable=YES/g; s/#ascii_upload_enable=YES/ascii_upload_enable=YES/g; s/#ascii_download_enable=YES/ascii_download_enable=YES/g; s/#chroot_local_user=YES/chroot_local_user=YES/g; s/#chroot_list_enable=YES/chroot_list_enable=YES/g; s/#chroot_list_file=\/etc\/vsftpd.chroot_list/chroot_list_file=\/etc\/vsftpd.chroot_list/g; s/#ls_recurse_enable=YES/ls_recurse_enable=YES/g' /etc/vsftpd.conf

# Ajoute des lignes à vsftpd.conf
echo "local_root=public_html" | sudo tee -a /etc/vsftpd.conf
echo "seccomp_sandbox=NO" | sudo tee -a /etc/vsftpd.conf

# Crée ou met à jour l'utilisateur bdertjv
sudo useradd -m -s /bin/bash -U bdertjv
echo "bdertjv:vitrygtr" | sudo chpasswd

# Écrit le nom d'utilisateur dans /etc/vsftpd.chroot_list
echo "bdertjv" | sudo tee /etc/vsftpd.chroot_list

# Redémarre le service vsftpd
sudo systemctl restart vsftpd

echo "Configuration terminée."

