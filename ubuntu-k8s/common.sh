#!/usr/bin/env bash

sudo -s 

#sudo ufw disable

sudo apt update
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release

# todo: vm restart시 swap 설정정보가 초기화됨 rc에 등록을 하는등 방안을 찾아서 해결해야함. (스크립트를 적용했으나 정상적으로 실행이 안됨)
# swapoff -a to disable swapping
# sed to comment the swap partition in /etc/fstab
printf "swapoff -a \nsed -i '/ swap / s/^/#/' /etc/fstab" | sudo tee -a /etc/init.d/disabled-swap.sh
sudo chmod 755 /etc/init.d/disabled-swap.sh
sudo /etc/init.d/disabled-swap.sh
sudo update-rc.d disabled-swap.sh defaults

cat <<-'EOF' >/etc/modules-load.d/kubernetes.conf
br_netfilter
EOF

sudo modprobe br_netfilter

cat <<-'EOF' >/etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd