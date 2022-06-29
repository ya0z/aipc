data digitalocean_ssh_key my-key {
    name = "macbook"
}
# create a Droplet for the code-server
resource digitalocean_droplet code-server {
    name = "code-server"
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
}
# create inventory.yaml file
resource local_file root_at_ngnix {
    filename = "inventory.yaml"
    file_permission = "0644"
    content = <<-EOT
all:
  vars:
    ansible_connection: ssh
  hosts:
    server-0:
      ansible_host: ${digitalocean_droplet.code-server.ipv4_address}
      ansible_user: root
      ansible_ssh_private_key_file: /home/fred/.ssh/root_id_rsa
    EOT
}