data digitalocean_ssh_key my-key {
    name = "macbook"
}

resource local_file macbook-public-key {
    filename = "macbook.pub"
    content = data.digitalocean_ssh_key.my-key.public_key
    file_permission = "0644"
}

output macbook_ssh_key_fingerprint {
    value = data.digitalocean_ssh_key.my-key.fingerprint
}

output macbook_ssh_key_id {
    value = data.digitalocean_ssh_key.my-key.id
}

/*-------*/
data docker_image dov-bear {
    name = "chukmunnlee/dov-bear:v2"
}

output dov-bear-md5 {
    value = data.docker_image.dov-bear.repo_digest
    description = "SHA of the image"
}

resource docker_container dov-bear-container {
    count = length(var.ports)
    name = "dov-bear-${count.index}"
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp-${count.index}",
        "INSTANCE_HASH=${count.index}"
    ]
    ports {
        internal = 3000
        external = var.ports[count.index]
    }
}

resource docker_container dov-bear-unqiue {
    for_each = var.containers
    name = each.key
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp-${each.key}"
    ]
    ports {
        internal = 3000
        external = each.value.external_port
    }
}

output container-names {
    value = [ for c in docker_container.dov-bear-container: c.name ]
}

resource local_file container-name {
    content = join("\n",[ for c in docker_container.dov-bear-container: c.name ])
    filename = "container-names.txt"
    file_permission = "0644"
}

resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.my-key.id]
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

output nginx_ip {
    value = digitalocean_droplet.nginx.ipv4_address
}

resource local_file root_at_ngnix {
    content = ""
    filename = "root@${digitalocean_droplet.nginx.ipv4_address}"
}