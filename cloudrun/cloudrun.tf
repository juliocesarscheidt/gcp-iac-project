resource "google_cloud_run_service" "cloudrun_service" {
  name     = "cloudrun-service-${var.env}"
  location = var.region
  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.image_name}:${var.image_tag}"
        env {
          name  = "API_PORT"
          value = 9000
        }
        env {
          name  = "MESSAGE"
          value = "Cloudrun App is running"
        }
        ports {
          name           = "http1"
          container_port = 9000
        }
        resources {
          requests = {
            cpu    = "0.25"
            memory = "512Mi"
          }
          limits = {
            cpu    = "1"
            memory = "1024Mi"
          }
        }
      }
      container_concurrency = 0
      timeout_seconds       = 300
      service_account_name  = var.service_account_name
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "1"
        "autoscaling.knative.dev/maxScale" = "1"
      }
      namespace = var.project_id
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

output "cloudrun_service_url" {
  # format: https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app
  value = google_cloud_run_service.cloudrun_service.status.*.url[0]
}

data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
}

locals {
  dns_name = "cloudrunapp.${substr(data.google_dns_managed_zone.dns_zone.dns_name, 0, length(data.google_dns_managed_zone.dns_zone.dns_name) - 1)}"
}

output "dns_name" {
  value = local.dns_name
}

resource "google_cloud_run_domain_mapping" "cloud_run_domain_mapping" {
  count    = var.cloud_mapping_enabled ? 1 : 0
  name     = local.dns_name
  location = var.region
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name       = google_cloud_run_service.cloudrun_service.name
    certificate_mode = "AUTOMATIC"
  }

  depends_on = [google_cloud_run_service.cloudrun_service]
}

output "cloud_run_domain_mapping" {
  value = length(google_cloud_run_domain_mapping.cloud_run_domain_mapping) > 0 ? google_cloud_run_domain_mapping.cloud_run_domain_mapping.0 : map()
}

output "cloud_run_domain_mapping_resource_records" {
  value = length(google_cloud_run_domain_mapping.cloud_run_domain_mapping) > 0 ? [for record in google_cloud_run_domain_mapping.cloud_run_domain_mapping.0.status.*.resource_records[0] : record.rrdata] : []
}

resource "google_dns_record_set" "cloud_run_recordset" {
  count        = var.cloud_mapping_enabled ? 1 : 0
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = "cloudrunapp.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "CNAME"
  rrdatas      = [for record in google_cloud_run_domain_mapping.cloud_run_domain_mapping.0.status.*.resource_records[0] : record.rrdata]
  ttl          = 300
}
