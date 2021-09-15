resource "google_compute_firewall" "vm_compute_firewall_ingress" {
  name      = "vm-compute-firewall-ingress"
  network   = google_compute_network.vm_compute_network.name
  direction = "INGRESS"
  priority  = 1000
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }
  # source_tags = [var.env]
  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_compute_network.vm_compute_network]
}
