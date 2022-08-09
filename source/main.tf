  terraform {
    required_providers {
      vagrant = {
        source  = "bmatcuk/vagrant"
        version = "~> 4.0.0"
      }
    }
  } 


  resource "vagrant_vm" "my_vagrant_vm" {
    name = "vagrantbox"
    vagrantfile_dir = "./Vagrantfile"
  }