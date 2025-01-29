provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "node_app" {
  image    = "ubuntu-22-04-x64"
  name     = "node-app-server"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key_id]
}

output "public_ip" {
  value = digitalocean_droplet.node_app.ipv4_address
}