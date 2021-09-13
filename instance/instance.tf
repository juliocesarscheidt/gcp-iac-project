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
  metadata_startup_script = "echo 'Starting...' > /startup.txt"
  service_account {
    email  = data.google_client_openid_userinfo.me.email
    scopes = ["cloud-platform"]
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }

  depends_on = [google_compute_disk.vm_compute_disk, google_compute_subnetwork.vm_compute_subnetwork_1]
}

# output "vm_instance" {
#   value = google_compute_instance.vm_instance
# }

output "vm_instance_nat_ip" {
  value = google_compute_instance.vm_instance.network_interface.*.access_config[0].*.nat_ip[0]
}
