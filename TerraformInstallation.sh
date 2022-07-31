#!/usr/bin/bash


#install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#add the official HashiCorp repository to your system.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

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
  apt install -y virtualbox
fi

#install vagrant
if ! vagrant -h 2&> /dev/null; then
  apt install -y vagrant
fi

#download and Install the package information from HashiCorp.
sudo apt-get install -y terraform

#install the autocomplete package.
terraform -install-autocomplete

#create main file terraform
touch main.tf






#change to main directory
mkdir /myproject
cd /myproject
