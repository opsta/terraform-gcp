resource "google_redis_instance" "redis" {
  count = var.database_type == "redis" ? 1 : 0

  name    = var.name
  project = var.project
  region  = var.region

  memory_size_gb          = var.memory_size_gb
  alternative_location_id = var.alternative_location_id
  authorized_network      = var.authorized_network
  connect_mode            = var.is_private == true ? "PRIVATE_SERVICE_ACCESS" : "DIRECT_PEERING"
  display_name            = var.display_name
  labels                  = var.labels
  redis_configs           = var.redis_configs
  location_id             = var.location_id
  redis_version           = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))
  reserved_ip_range       = var.reserved_ip_range
  tier                    = var.enable_ha ? "STANDARD_HA" : "BASIC"

  depends_on = [google_service_networking_connection.private_service_connection]
}

resource "google_compute_global_address" "service_range" {
  count = var.is_private == true ? 1 : 0

  name          = "${var.name}-priavte-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.authorized_network
}

resource "google_service_networking_connection" "private_service_connection" {
  count = var.is_private == true ? 1 : 0

  network                 = var.authorized_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.service_range[0].name]
}
