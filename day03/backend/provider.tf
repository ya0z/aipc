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
    aws = {
      source = "hashicorp/aws"
      version = "4.20.1"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
  backend s3 {
    //only for non AWS S3
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    endpoint = "https://sgp1.digitaloceanspaces.com"
    region = "sgp1"
    bucket = "aipcbucket-yaomin"
    key = "states/terraform.tfstate"
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.DO_token
}