#!/usr/bin/bash

#change to main directory
sudo rm -rf /myproject
sudo mkdir /myproject
cd /myproject

#install the HashiCorp GPG key.
sudo wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#add the official HashiCorp repository to your system.
sudo echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

#update repositories
sudo apt update -y

#install HashiCorp's Debian package repository.
sudo apt-get install -y gnupg software-properties-common

#verify the key's fingerprint.
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
<<comment
The gpg command will report the key fingerprint:
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 2020-05-07 [SC]
      E8A0 32E0 94D8 EB4E A189  D270 DA41 8C88 A321 9F7B
uid           [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 2020-05-07 [E]
comment


#check dependancies and install them
if ! unzip -h 2&> /dev/null; then
  sudo apt install -y unzip
fi

if ! curl -h 2&> /dev/null; then
  sudo apt install  -y curl
fi

if ! wget -h 2&> /dev/null; then
  sudo apt install  -y wget
fi

if ! jq --version 2&> /dev/null; then
  sudo apt install -y jq
fi

#install virtualbox for vagrant
if ! vboxmanage -h 2&> /dev/null; then
 sudo apt install -y virtualbox
fi

#install vagrant
if ! vagrant -h 2&> /dev/null; then
  sudo apt install -y vagrant
fi

#install terraform
sudo apt-get install -y terraform

#install the autocomplete package.
sudo terraform -install-autocomplete

#install ansible
sudo apt install ansible

#
vagrant box add ubuntu/focal64

#hard add config to terraform file
echo 'terraform {
  required_providers {
    vagrant = {
      source  = "bmatcuk/vagrant"
      version = "~> 4.0.0"
    }
  }
}

resource "vagrant_vm" "my_vagrant_vm" {
  env = {
    # force terraform to re-run vagrant if the Vagrantfile changes
    VAGRANTFILE_HASH = md5(file("./Vagrantfile")),
  }
  get_ports = true
  # see schema for additional options
}' > main.tf



echo 'Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.network "forwarded_port", guest: 22, host: 221
  
    config.vm.provider "VirtualBoxe" do |vb|
    end
  
    config.vm.define "master" do |master|
      master.vm.box = "ubuntu/focal64"
      master.vm.hostname = "master"
      master.vm.provider :VirtualBox do |v|
        v.customize ['modifyvm', :id, '--memory', '2048']
        v.customize ['modifyvm', :id, '--cpus', '2']
      end
    end
    config.vm.define "slave1" do |slave1|
      slave1.vm.box = "ubuntu/focal64"
      slave1.vm.hostname = "slave1"
      slave1.vm.provider :VirtualBox do |v|
        v.customize ['modifyvm', :id, '--memory', '2048']
        v.customize ['modifyvm', :id, '--cpus', '2']
      end
    end
    config.vm.define "slave2" do |slave2|
      slave2.vm.box = "ubuntu/focal64"
      slave2.vm.hostname = "slave2"
      slave2.vm.provider :VirtualBox do |v|
        v.customize ['modifyvm', :id, '--memory', '2048']
        v.customize ['modifyvm', :id, '--cpus', '2']
      end
    end
  end' > Vagrantfile

terraform init








