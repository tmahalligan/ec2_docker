#!/bin/bash

# Install kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update && sudo apt-get install -y kubectl


# Install yq
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq -y
sudo apt update && sudo apt install yq awscli -y

# Remove any old Docker items
sudo apt remove docker docker-engine docker.io containerd runc

# Install all pre-reqs for Docker
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add the Docker repository, we are installing from Docker and not the Ubuntu APT repo.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add your base user to the Docker group so that you do not need sudo to run docker commands
sudo usermod -aG docker ubuntu

# Install Python pip  jq unzip
sudo apt-get install -y python3-pip jq unzip

# Install ansible
sudo pip install ansible

# Install k3d
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash


# Install sops
wget https://github.com/mozilla/sops/releases/download/v3.7.1/sops_3.7.1_amd64.deb
sudo dpkg -i sops_3.7.1_amd64.deb
sudo rm sops_3.7.1_amd64.deb

# Install Trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.0/trivy_0.18.0_Linux-64bit.deb
sudo dpkg -i trivy_0.18.0_Linux-64bit.deb
sudo rm trivy_0.18.0_Linux-64bit.deb

# Install Terraform
wget https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip
sudo unzip terraform_1.0.5_linux_amd64.zip
sudo mv terraform /usr/local/bin
sudo rm terraform*


# Install k9s
sudo wget https://github.com/derailed/k9s/releases/download/v0.24.15/k9s_Linux_x86_64.tar.gz
sudo tar -xvf k9s_Linux_x86_64.tar.gz
sudo mv k9s /usr/local/bin/k9s

# Install Kubescape
curl -s https://raw.githubusercontent.com/armosec/kubescape/master/install.sh | /bin/bash

# Install Carvel Tools
wget -O- https://carvel.dev/install.sh | bash