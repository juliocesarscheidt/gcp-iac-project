resource "google_compute_disk" "vm_compute_disk" {
  name  = "vm-compute-disk"
  type  = "pd-ssd"
  zone  = var.zone
  image = var.instance_image
  labels = {
    environment = var.env
  }
  physical_block_size_bytes = 4096 # 4GB
}
