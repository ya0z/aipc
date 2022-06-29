variable "DO_token" {
  type = string
  sensitive = true
}

variable "ports" {
  type = list(number)
  default = [8080,8081,8082,8083]
}

variable "containers" {
  type = map(object({
    external_port = number
  }))
  default = {  
    abc: {
        external_port = 1234
    }
    xyz: {
        external_port = 9090
    }
  }
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
  default = "s-1vcpu-1gb"
}

variable DO_private_key {
  type = string
  default = "/home/fred/.ssh/root_id_rsa"
}