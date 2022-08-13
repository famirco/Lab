#!/usr/bin/bash

#Update repositories
sudo apt update -y 1>/dev/null
echo '############### Apt update completed successfully.###############'

#Install Ansible
sudo apt install -y python3 python3-pip ansible yamllint ansible-lint
echo '############### Ansible installation completed successfully.###############'

echo 'controlmachine ansible-host=127.0.0.1' >> /etc/ansible/hosts


ansible-playbook ansible-playbooks/ConfigureLocal.yml