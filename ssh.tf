locals {
  metadata_ssh_content = "google:${file("${path.module}/ssh_key.pub")}"
}

resource "google_compute_project_metadata" "metadata_ssh" {
  metadata = {
    ssh-keys = local.metadata_ssh_content
  }
}
