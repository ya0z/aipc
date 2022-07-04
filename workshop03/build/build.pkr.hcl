variable DO_token {
    type = string
    sensitive = true
}
variable codeserver_ver {
    type = string
    default = "4.4.0"
}
source digitalocean mydroplet {
    api_token = var.DO_token 
    image = "ubuntu-20-04-x64"
    size = "s-2vcpu-2gb"
    region = "sgp1"
    ssh_username = "root"
    snapshot_name = "code-server:${var.codeserver_ver}"
}

build {
    sources = [ "source.digitalocean.mydroplet" ]

    provisioner ansible {
        playbook_file = "playbook.yaml"
    }
}