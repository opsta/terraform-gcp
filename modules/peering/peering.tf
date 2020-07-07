# resources
resource "google_compute_network_peering" "peering1" {
  name                                = var.name + "-1"
  network                             = var.network
  peer_network                        = var.peer_network
  export_custom_routes                = var.export_custom_routes
  import_custom_routes                = var.import_custom_routes
  export_subnet_routes_with_public_ip = var.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = var.import_subnet_routes_with_public_ip
}

resource "google_compute_network_peering" "peering2" {
  name                                = var.name + "-2"
  network                             = var.peer_network
  peer_network                        = var.network
  export_custom_routes                = var.export_custom_routes
  import_custom_routes                = var.import_custom_routes
  export_subnet_routes_with_public_ip = var.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = var.import_subnet_routes_with_public_ip
}

# variables
variable "name" {
  description = "Name of the peering."
  type        = string
}

variable "enable_two_way_peering" {
  description = "Use to create peering for both of network."
  type        = true
}

variable "network" {
  description = "The primary network of the peering."
  type        = string
}

variable "peer_network" {
  description = "The peer network in the peering. The peer network may belong to a different project."
  type        = string
}

variable "export_custom_routes" {
  description = "Whether to export the custom routes to the peer network."
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Whether to export the custom routes from the peer network."
  type        = bool
  default     = false
}

variable "export_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are exported. The default value is true, all subnet routes are exported. The IPv4 special-use ranges (https://en.wikipedia.org/wiki/IPv4#Special_addresses) are always exported to peers and are not controlled by this field."
  type        = bool
  default     = true
}

variable "import_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are imported. The default value is false. The IPv4 special-use ranges."
  type        = bool
  default     = false
}

# outputs
output "network_id" {
  description = "an identifier for the resource with format {{network}}/{{name}}"
  value       = "google_compute_network_peering.peering1.id"
}

output "peer_network_id" {
  description = "an identifier for the resource with format {{network}}/{{name}}"
  value       = "google_compute_network_peering.peering2.id"
}

output "network_state" {
  description = "State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network."
  value       = "google_compute_network_peering.peering1.state"
}

output "peer_network_state" {
  description = "State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network."
  value       = "google_compute_network_peering.peering2.state"
}

output "network_state_details" {
  description = "Details about the current state of the peering."
  value       = "google_compute_network_peering.peering1.state"
}

output "peer_network_state_details" {
  description = "Details about the current state of the peering."
  value       = "google_compute_network_peering.peering2.state"
}
