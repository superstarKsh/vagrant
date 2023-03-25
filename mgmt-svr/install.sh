#!/usr/bin/env bash

# docker 
sudo apt update
sudo apt-get install -y ca-certificates \ 
    curl \
    software-properties-common \
    apt-transport-https \
    gnupg \
    lsb-release \
    jq 

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io

# mysql client
sudo apt -y install mysql-client

# python3 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.8

# k9s https://github.com/derailed/k9s/
curl -sS https://webinstall.dev/k9s | bash
export PATH="/home/vagrant/.local/bin:$PATH"

# kubectl 
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubectl completion bash >/etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >> /home/vagrant/.bashrc

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo 'alias h=helm' >> /home/vagrant/.bashrc