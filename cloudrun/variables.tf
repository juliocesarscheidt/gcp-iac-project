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

variable "dns_zone_name" {
  type        = string
  description = "DNS Zone Name"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment"
}
