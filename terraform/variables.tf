variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID to deploy resources into."
}

variable "gcp_region" {
  type        = string
  description = "The GCP region for the resources."
  default     = "asia-east1"
}

variable "gcp_zone" {
  type        = string
  description = "The GCP zone for the resources."
  default     = "asia-east1-b"
}