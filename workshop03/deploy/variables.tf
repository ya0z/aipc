variable DO_token {
    type = string 
    sensitive = true
}
variable DO_private_key {
    type = string 
    sensitive = true
}
variable DO_image {
    type = string
    default = "ubuntu-20-04-x64"
}
variable DO_region {
    type = string
    default = "sgp1"
}
variable DO_size {
    type = string
    default = "s-2vcpu-2gb"
}
variable codeserver-ver {
    type = string
    default = "4.4.0"
}
variable code_server {
  type = string
  default = "codeserver"
}
variable cs_password {
    type = string
    sensitive = true
}

variable codeserver_domain {
    type = string
    default = "127.0.0.1"
}