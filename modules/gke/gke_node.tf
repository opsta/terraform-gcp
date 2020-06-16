# resources
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    preemptible  = var.preemptible
    machine_type = var.machine_type
    tags         = ["gke-node", google_container_cluster.primary.name]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# variables
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
