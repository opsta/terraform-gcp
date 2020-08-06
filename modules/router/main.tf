resource "google_compute_router" "router" {
  name        = var.name
  network     = var.network
  description = var.description

  project = var.project_id
  region  = var.region

  dynamic "bgp" {
    for_each = var.asn == null ? [] : [{ "key" = "value" }]
    content {
      asn               = var.asn
      advertise_mode    = var.advertise_mode
      advertised_groups = var.advertised_groups

      dynamic "advertised_ip_ranges" {
        for_each = var.advertised_ip_ranges
        content {
          range       = advertised_ip_ranges.value["range"]
          description = advertised_ip_ranges.value["description"]
        }
      }
    }
  }
}
