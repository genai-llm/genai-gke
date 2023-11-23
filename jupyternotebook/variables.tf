variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "genai-poc-403304"
}

variable "region" {
  type        = string
  description = "GCP project region or zone"
  default     = "asia-southeast1"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
  default     = "jupyter-cluster"
}
