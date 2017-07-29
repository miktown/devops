resource "digitalocean_loadbalancer" "devops" {
  name = "devops-html-v2"
  region = "lon1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
  }

  droplet_tag = "${digitalocean_tag.devops.name}"
}

resource "digitalocean_tag" "devops" {
	name = "devops-html"
}

resource "digitalocean_droplet" "devops" {
  count  = 2
  image  = "26667153"
  name   = "devops-v2"
  region = "lon1"
  size   = "512mb"
  ssh_keys = [1692816]
  tags   = ["${digitalocean_tag.devops.id}"]

  user_data = <<EOF
#cloud-config
coreos:
  units:
    - name: "devops.service"
      command: "start"
      content: |
        [Unit]
        Description=Devops Demo
        After=docker.service

        [Service]
        ExecStart=/usr/bin/docker run -d -p 3000:3000 devops
EOF
}


