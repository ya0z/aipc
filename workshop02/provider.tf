terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.21.0"
    }
    hashicorp = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.DO_token
}