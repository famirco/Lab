#!/usr/bin/bash

sudo rm -rf Myproject
sudo mkdir Myproject


if ls Myproject 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'Myproject directory has been created successfully.'
  else
  echo '.**######################################################################################**.'
  echo 'WE can not create directory.'
  exit 1
fi

cd Myproject

#install the HashiCorp GPG key.
if cat /usr/share/keyrings/hashicorp-archive-keyring.gpg 1>/dev/null 2>&1; then
  echo '.**######################################################################################**.'
  echo 'HashiCorp GPG key is already installed.'
  else
  sudo wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg 1>/dev/null
  echo '.**######################################################################################**.'
  echo 'Install HashiCorp GPG key completed successfully.'
fi


#add the official HashiCorp repository to your system.
if cat /etc/apt/sources.list.d/hashicorp.list 1>/dev/null 2>&1; then
  echo '.**######################################################################################**.'
  echo 'The official HashiCorp repository already have to your system.'
  else
  sudo echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list 1>/dev/null
  echo '.**######################################################################################**.'
  echo 'The official HashiCorp repository has been added to your system.'
fi

#update repositories
sudo apt update -y 1>/dev/null
echo '.**######################################################################################**.'
echo 'Apt update completed successfully.'


#verify the key's fingerprint.
echo '.**######################################################################################**.'
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

echo 'The gpg command will report the key fingerprint:
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 2020-05-07 [SC]
      E8A0 32E0 94D8 EB4E A189  D270 DA41 8C88 A321 9F7B
uid           [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 2020-05-07 [E]'


#check dependancies and install them
if unzip -h 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'Unzip is already installed.'
  else
  sudo apt install -y unzip 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( Unzip ) Installation completed successfully.'
fi

if curl -h 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'curl is already installed.'
  else
  sudo apt install  -y curl 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( curl ) Installation completed successfully.'
fi

if wget -h 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'wget is already installed.'
  else
  sudo apt install  -y wget 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( wget ) Installation completed successfully.'
fi

if jq --version 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'jq is already installed.'
  else
  sudo apt install -y jq 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( jq ) Installation completed successfully.'
fi

#install virtualbox for vagrant
if vboxmanage -h 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'Virtualbox is already installed.'
  else
  sudo apt install -y virtualbox 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( Virtualbox ) Installation completed successfully.'
fi

#install vagrant
if vagrant -h 1>/dev/null; then
  echo '.**######################################################################################**.'
  echo 'Vagrant is already installed.'
  else
  sudo apt install -y vagrant 1>/dev/null
  echo '.**######################################################################################**.'
  echo '( Vagrant ) Installation completed successfully.'
fi

#install terraform
sudo apt-get install -y terraform 1>/dev/null
echo '.**######################################################################################**.'
echo '( Vagrant ) Installation completed successfully.'

#install ansible
sudo apt install ansible 1>/dev/null
echo '.**######################################################################################**.'
echo '( Vagrant ) Installation completed successfully.'

#
vagrant box add ubuntu/focal64
echo '.**######################################################################################**.'
echo '( ubuntu/focal64 ) Added to box.'


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
#  config.vm.network "forwarded_port", guest: 22, host: 221

  config.vm.provider "VirtualBoxe" do |vb|
  end

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/focal64"
    ansible.vm.hostname = "ansible"
    ansible.vm.provider :VirtualBox do |v|
      v.customize ['modifyvm', :id, '--memory', '2048']
      v.customize ['modifyvm', :id, '--cpus', '2']
    end
  end
  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/focal64"
    ansible.vm.hostname = "ansible"
    ansible.vm.provider :VirtualBox do |v|
      v.customize ['modifyvm', :id, '--memory', '2048']
      v.customize ['modifyvm', :id, '--cpus', '2']
    end
  end
  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/focal64"
    ansible.vm.hostname = "ansible"
    ansible.vm.provider :VirtualBox do |v|
      v.customize ['modifyvm', :id, '--memory', '2048']
      v.customize ['modifyvm', :id, '--cpus', '2']
    end
  end
end' > Vagrantfile

vagrant init
terraform init








