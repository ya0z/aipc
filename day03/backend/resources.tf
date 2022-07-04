data digitalocean_ssh_key my-key {
    name = "macbook"
}

resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.my-key.id ]
    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.DO_private_key)
        host = self.ipv4_address
    }
    provisioner remote-exec {
        inline = [
            "apt update",
            "apt install nginx -y",
            "systemctl enable nginx",
            "systemctl start nginx"
        ]
    }
}
