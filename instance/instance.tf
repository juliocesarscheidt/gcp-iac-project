resource "google_compute_instance" "vm_instance" {
  name           = "vm-instance"
  machine_type   = var.instance_type
  zone           = var.zone
  can_ip_forward = true
  # network tags
  tags = [var.env]
  metadata = {
    environment = var.env
  }
  boot_disk {
    auto_delete = true
    device_name = "vm-instance" # /dev/disk/by-id/google-{{device_name}}
    source      = google_compute_disk.vm_compute_disk.self_link
  }
  network_interface {
    subnetwork = google_compute_subnetwork.vm_compute_subnetwork_1.self_link
    access_config {}
  }
  metadata_startup_script = <<EOF
sudo apt-get update -y && apt-get install curl -y

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io 2> /dev/null
sudo apt clean

sudo groupadd docker 2> /dev/null
sudo usermod -aG docker ${var.instance_username} 2> /dev/null

sudo systemctl start docker.service

docker image pull juliocesarmidia/http-simple-api:v1.0.0
docker container run -d --name api --publish 80:9000 --restart=always juliocesarmidia/http-simple-api:v1.0.0

# cat /var/log/daemon.log
EOF

  service_account {
    email  = data.google_client_openid_userinfo.me.email
    scopes = ["cloud-platform"]
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }

  depends_on = [google_compute_disk.vm_compute_disk, google_compute_subnetwork.vm_compute_subnetwork_1]
}

output "vm_instance_nat_ip" {
  value = google_compute_instance.vm_instance.network_interface.*.access_config[0].*.nat_ip[0]
}
