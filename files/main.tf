terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.20.3"
    }
  }
}

provider "docker" {
}

# Pulls the image
resource "docker_image" "alpine" {
  name = "alpine:3"
  keep_locally = true
}

# Create a container
resource "docker_container" "foo" {
  image = docker_image.alpine
  name  = "foo"
}