data "google_iam_policy" "noauth_iam_policy" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloudrun_service.location
  project     = google_cloud_run_service.cloudrun_service.project
  service     = google_cloud_run_service.cloudrun_service.name
  policy_data = data.google_iam_policy.noauth_iam_policy.policy_data

  depends_on = [google_cloud_run_service.cloudrun_service]
}
