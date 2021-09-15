variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Project Region"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "Project Zone"
  default     = "us-east1-a"
}

variable "service_account_name" {
  type        = string
  description = "Service Account Name"
}

variable "image_name" {
  type        = string
  description = "Image Name"
  default     = "http-simple-api"
}

variable "image_tag" {
  type        = string
  description = "Image Tag"
  default     = "v1.0.0"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "cloud_mapping_enabled" {
  type        = bool
  description = "Enable Cloud Mapping"
  default     = false
}

variable "dns_zone_name" {
  type        = string
  description = "DNS Zone Name"
}

