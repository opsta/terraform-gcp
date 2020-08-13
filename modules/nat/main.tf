resource "google_compute_router_nat" "nat" {
  name                               = var.name
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  router                             = var.router

  nat_ips       = var.nat_ips
  drain_nat_ips = var.drain_nat_ips

  dynamic "subnetwork" {
    for_each = var.source_subnetwork_ip_ranges_to_nat == "LIST_OF_SUBNETWORKS" ? var.subnetwork : []
    content {
      name                     = subnetwork.value["name"]
      source_ip_ranges_to_nat  = subnetwork.value["source_ip_ranges_to_nat"]
      secondary_ip_range_names = subnetwork.value["secondary_ip_range_names"]
    }
  }

  min_ports_per_vm                 = var.min_ports_per_vm
  udp_idle_timeout_sec             = var.udp_idle_timeout_sec
  icmp_idle_timeout_sec            = var.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec  = var.tcp_transitory_idle_timeout_sec

  dynamic "log_config" {
    for_each = var.log_config
    content {
      enable = log_config.value["enable"]
      filter = log_config.value["filter"]
    }
  }

  region  = var.region
  project = var.project_id
}
