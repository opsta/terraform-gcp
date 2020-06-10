# resources
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_secondary_range_name  = null
    cluster_ipv4_cidr_block       = var.pod_range
    services_secondary_range_name = null
    services_ipv4_cidr_block      = var.service_range
  }

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# variables
variable "location" {
  description = "GKE cluster location specific region will create multi cluster master"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "name of GKE cluster to provision"
  type        = string
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

variable "preemptible" {
  description = "Enable preemptible for compute engine"
  type        = bool
  default     = false
}

variable "pod_range" {
  description = "The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size"
  type        = string
  default     = null
}

variable "service_range" {
  description = "The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size"
  type        = string
  default     = null
}

# output
output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}
