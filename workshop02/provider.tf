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
  #token = "dop_v1_8db8e34c2c445890bebc8aeeb37c01add994e8a0c46e1bf93a1c5a4e2a899530"
  token = var.DO_token
}