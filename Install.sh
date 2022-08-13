#!/usr/bin/bash

#Update repositories
sudo apt update -y 1>/dev/null
echo '############### Apt update completed successfully.###############'

#Install Ansible
sudo apt install -y python3 python3-pip ansible yamllint ansible-lint
echo '############### Ansible installation completed successfully.###############'




ansible-playbook -i ansible-playbooks/hosts ansible-playbooks/ConfigureLocal.yml