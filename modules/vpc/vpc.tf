resource "google_compute_network" "vpc" {
  name    = var.name
  project = var.project_id

  description                     = var.description
  auto_create_subnetworks         = var.enabled_subnet
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create

  timeouts {
    create = var.timeout
    update = var.timeout
    delete = var.timeout
  }
}

resource "google_compute_subnetwork" "subnet" {
  count = var.enabled_subnet == true ? 1 : 0

  name    = "${var.cluster_name}-subnet"
  project = var.project_id
  region  = var.region

  ip_cidr_range = "10.10.0.0/24"
  network       = google_compute_network.vpc.name
  description   = null

  # purpose = null #beta
  # role = null #beta

  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }

  private_ip_google_access = null

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = null
    metadata             = null
  }
}
