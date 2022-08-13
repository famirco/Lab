#!/usr/bin/bash

#Update repositories
sudo apt update -y 1>/dev/null
echo '############### Apt update completed successfully.###############'

#Install Ansible
sudo apt install -y ansible
echo '############### Ansible installation completed successfully.###############'

ansible_host=$(cat /etc/ansible/hosts | awk '{print $2}')
if [ ! ansible_host == 'ansible_host=127.0.0.1' ];then
    echo '[servers]
server1 ansible_host=127.0.0.1


[all:vars]
ansible_python_interpreter=/usr/bin/python3' >> cat /etc/ansible/hosts
fi



