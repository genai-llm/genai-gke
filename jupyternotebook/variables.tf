variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "PROJECT_ID"
}

variable "region" {
  type        = string
  description = "GCP project region or zone"
  default     = "us-central1-a"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
  default     = "ml-cluster"
}
