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
