source digitalocean mydroplet { 
  api_token = var.DO_TOKEN 
  region = var.region
  size = var.droplet.size
  image = var.droplet.image 
  snapshot_name = “mydroplet” 
  ssh_username = “root”
}