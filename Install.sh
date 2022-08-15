#!/usr/bin/bash

#Add repo and Update repositories
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -y 1>/dev/null
echo '############### Add repo and Apt update completed successfully.###############'

#Install Ansible
sudo apt install -y python3 python3-pip ansible yamllint ansible-lint 1>/dev/null   
echo '############### Ansible installation completed successfully.###############'

#ssh-copy-id root@127.0.0.1


ansible-playbook -i files/hosts files/ConfigureLocal.yml