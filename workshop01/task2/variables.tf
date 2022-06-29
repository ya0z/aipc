variable "DO_token" {
  type = string
  sensitive = true
}

variable nwapp-image {
  type = string
  default = "stackupiss/northwind-app:v1"
}

variable nwdb-image {
  type = string
  default = "stackupiss/northwind-db:v1"
}

variable mynet {
  type = string
  default = "mynet"
}

variable myvol {
  type = string
  default = "myvol"
}