#!/usr/bin/env bash
sudo -s 

cat <<-'EOF' >/etc/default/kubelet
KUBELET_EXTRA_ARGS=--node-ip=192.168.56.MW_POST_FIX
EOF

# master/node ip is postfix = 10 and other nodes>10+i
sed -i "s/MW_POST_FIX/1$1/g" /etc/default/kubelet

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
 
if [ $2 = 'MASTER' ]; then
  OUTPUT_FILE=/vagrant/join.sh
  # share .kube config 삭제 
  rm -rf /vagrant/.kube

  sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=192.168.56.10 --apiserver-advertise-address=192.168.56.10
  sudo kubeadm token create --print-join-command > $OUTPUT_FILE

  chmod +x $OUTPUT_FILE
  mkdir -p $HOME/.kube

  sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  cp -R $HOME/.kube /vagrant/.kube
  cp -R $HOME/.kube /home/vagrant/.kube

  sudo chown -R vagrant:vagrant /home/vagrant/.kube

  # kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
  # CNI CALICO로 변경처리 
  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
  kubectl completion bash >/etc/bash_completion.d/kubectl
  echo 'alias k=kubectl' >> /home/vagrant/.bashrc
  
  systemctl restart kubelet

fi