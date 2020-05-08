variable "project_id" {
  description = "project id"
  type        = string
}

variable "region" {
  description = "region"
  default     = "asia-southeast1"
  type        = string
}

variable "cluster_name" {
  description = "name of gke cluster"
  type        = string
  default     = ""
}

variable "gke_username" {
  description = "gke username"
  type        = string
  default     = ""
}

variable "gke_password" {
  description = "gke password"
  type        = string
  default     = ""
}

variable "node_count" {
  description = "number of gke nodes per zone"
  type        = number
  default     = 1
}

variable "machine_type"{
  description = "type of machine to run as worker"
  type = string
  default = "n1-standard-1"
}