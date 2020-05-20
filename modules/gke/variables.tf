variable "project_id" {
  description = "project id to provision GKE"
  type        = string
}

variable "region" {
  description = "region to create VPC"
  default     = "asia-southeast1"
  type        = string
}

variable "zone" {
  description = "zone of GKE cluster [a, b, c] (empty for enable multi zone cluster)"
  default     = ""
  type        = string
}

variable "cluster_name" {
  description = "name of GKE cluster to provision"
  type        = string
  default     = ""
}

variable "gke_username" {
  description = "GKE username"
  type        = string
  default     = ""
}

variable "gke_password" {
  description = "GKE password"
  type        = string
  default     = ""
}

variable "node_count" {
  description = "number of GKE nodes per zone"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "type of machine to run as workers"
  type        = string
  default     = "n1-standard-1"
}

/// TODO: Add more variables to support all values of GKE module 
// preemptible
// all
