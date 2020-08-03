resource "google_compute_network" "vpc" {
  name    = var.name
  project = var.project_id

  description                     = var.description
  auto_create_subnetworks         = false
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create

  timeouts {
    create = var.timeout
    update = var.timeout
    delete = var.timeout
  }
}

resource "google_compute_subnetwork" "subnets" {
  count = length(var.subnets)

  network     = google_compute_network.vpc.name
  description = var.description
  project     = var.project_id
  region      = var.region

  name          = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].ip_cidr_range

  # role = null # TODO: Implement when it out of beta
  # purpose = null # TODO: Implement when it out of beta

  secondary_ip_range       = var.subnets[count.index].secondary_ip_range
  private_ip_google_access = var.subnets[count.index].private_ip_google_access

  dynamic "log_config" {
    for_each = var.subnets[count.index].log_config == null ? [] : [{ "key" = "value" }]
    content {
      aggregation_interval = var.subnets[count.index].log_config.aggregation_interval
      flow_sampling        = var.subnets[count.index].log_config.flow_sampling
      metadata             = var.subnets[count.index].log_config.meta_data
    }
  }
}
