resource "google_compute_firewall" "firewall" {
  name                    = var.name
  network                 = var.network
  description             = var.description
  destination_ranges      = var.destination_ranges
  direction               = var.direction
  disabled                = var.disabled
  priority                = var.priority
  source_ranges           = var.source_ranges
  source_service_accounts = var.source_service_accounts
  source_tags             = var.source_tags
  target_service_accounts = var.target_service_accounts
  target_tags             = var.target_tags
  project                 = var.project

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.value["protocol"]
      ports    = allow.value["ports"]
    }
  }

  dynamic "deny" {
    for_each = var.deny
    content {
      protocol = deny.value["protocol"]
      ports    = deny.value["ports"]
    }
  }
}
