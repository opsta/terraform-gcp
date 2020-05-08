# VPC
resource "google_compute_network" "vpc" {
  name                    = var.cluster_name != "" ? "${var.cluster_name}-vpc" : "${var.project_id}-gke-default-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.cluster_name != "" ? "${var.cluster_name}-subnet" : "${var.project_id}-gke-default-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
