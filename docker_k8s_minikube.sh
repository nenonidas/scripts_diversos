#!/bin/bash

# Instalando o Docker
echo "Instalando o Docker"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Instalando o Kubernetes e Minikube
echo "Instalando o Kubernetes e Minikube"
apt-get install -y conntrack
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install kubectl /usr/local/bin/kubectl

# Configuração do Minikube
echo "Configurando o Minikube"
usermod -aG docker $USER
newgrp docker
sysctl net.bridge.bridge-nf-call-iptables=1
minikube config set driver docker
minikube config set cpus 2
minikube config set memory 4096

# Inicializa o Minikube
echo "Inicializando o Minikube"
minikube start

# Verificando as instalações
echo "Verificando as instalações"
minikube status
kubectl version --client
docker --version

echo "instalação finalizada"
