data digitalocean_ssh_key my-key {
    name = "macbook"
}

data digitalocean_image codeserver-img {
    name = "code-server:${var.codeserver-ver}"
}

resource digitalocean_droplet code-server {
    name = var.code_server
    image = data.digitalocean_image.codeserver-img.id
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.my-key.id]
    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.DO_private_key)
        host = self.ipv4_address
    }
    provisioner "remote-exec" {
        inline = [
            "sed -i -e 's/__SET_THIS__/${var.cs_password}/' /lib/systemd/system/code-server.service",
            "sed -i -e 's/__SET_THIS__/${var.code_server}-${digitalocean_droplet.code-server.ipv4_address}.nip.io/' /etc/nginx/sites-available/code-server.conf",
            "systemctl daemon-reload",
            "systemctl restart code-server",
            "systemctl restart nginx"
        ]
    }
}
output domain_name {
    value = "${var.code_server}-${digitalocean_droplet.code-server.ipv4_address}.nip.io"
}

/* resource local_file inventory_yaml {
  content = templatefile("inventory.yaml.tpl", {
    ssh_private_key = var.DO_private_key
    codeserver = var.code_server
    droplet_ip = digitalocean_droplet.code-server.ipv4_address
    codeserver_domain = "${var.code_server}-${digitalocean_droplet.code-server.ipv4_address}.nip.io"
    codeserver_password = var.cs_password
  })
  filename = "inventory.yaml"
  file_permission = "0644"
} */