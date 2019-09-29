#!/bin/bash

hostname=$1
#ip=$2 # should be of format: 192.168.1.100
#dns=$3 # should be of format: 192.168.1.1

echo "Updating and upgrading host system"
sudo apt update && apt upgrade -y

#Install Docker
echo "installing and enabling docker"

# Install Docker
curl -sSL get.docker.com | sh && \
sudo usermod pi -aG docker
#sudo apt install docker.io

echo "Add joel to docker group"
sudo usermod joel -aG docker

# Disable Swap
echo "disable swap"
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove
echo Adding " cgroup_enable=cpuset cgroup_enable=memory" to /boot/cmdline.txt
sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt

# Change the hostname
sudo hostnamectl --transient set-hostname $hostname
sudo hostnamectl --static set-hostname $hostname
sudo hostnamectl --pretty set-hostname $hostname
sudo sed -i s/raspberrypi/$hostname/g /etc/hosts

#Disable swap
#sudo dphys-swapfile swapoff && \
#  sudo dphys-swapfile uninstall && \
#  sudo update-rc.d dphys-swapfile remove

#enable cgroup
#echo Adding " cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" to /boot/cmdline.txt

#sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
#orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"
#echo $orig | sudo tee /boot/cmdline.txt

echo "please restart the machine"