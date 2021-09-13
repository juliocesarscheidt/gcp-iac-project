resource "google_compute_network" "vm_compute_network" {
  name                    = "vm-compute-network"
  auto_create_subnetworks = "false"
  mtu                     = 1500
}

resource "google_compute_subnetwork" "vm_compute_subnetwork_1" {
  name          = "vm-compute-subnetwork-1"
  ip_cidr_range = "10.100.0.0/24"
  region        = var.region
  network       = google_compute_network.vm_compute_network.id

  depends_on = [google_compute_network.vm_compute_network]
}
