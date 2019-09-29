#!/bin/bash
#https://stevenbreuls.com/2019/01/install-docker-on-raspberry-pi/
echo "Basic setup for docker"

#Update system
sudo apt update && sudo apt upgrade -y

#docker setup
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

curl -fsSL https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -

echo "deb [arch=armhf] https://download.docker.com/linux/raspbian stretch stable" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update

sudo apt install docker-ce

sudo usermod -aG docker joel

sudo reboot -n

