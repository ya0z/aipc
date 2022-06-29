variable "DO_token" {
  type = string
  sensitive = true
}

variable DO_region {
  type = string
  default = "SGP1"
}

variable DO_image {
  type = string
  default = "ubuntu-20-04-x64"
}

variable DO_size {
  type = string
  default = "s-2vcpu-2gb"
}
variable DO_private_key {
  type = string
  default = "/home/fred/.ssh/root_id_rsa"
}