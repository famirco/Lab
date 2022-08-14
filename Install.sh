#!/usr/bin/bash

#Update repositories
sudo apt update -y 1>/dev/null
echo '############### Apt update completed successfully.###############'

#Install Ansible
sudo apt install -y python3 python3-pip ansible yamllint ansible-lint 1>/dev/null   
echo '############### Ansible installation completed successfully.###############'

#ssh-copy-id root@127.0.0.1


ansible-playbook -i ansible-files/hosts ansible-files/ConfigureLocal.yml