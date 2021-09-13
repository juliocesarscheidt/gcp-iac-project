provider "google" {
  # credentials = file("GOOGLE_CLOUD_KEYFILE_JSON.json")
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
