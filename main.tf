terraform {
  required_providers {
    vagrant = {
      source = "lippertmarkus/vagrant"
      version = "2.0.0"
    }
  }
}

provider "vagrant" {
  source = "./Vagrantfile"
}