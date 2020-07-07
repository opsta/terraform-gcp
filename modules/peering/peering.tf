# resources
resource "google_compute_network_peering" "peering1" {
  name         = "peering1"
  network      = google_compute_network.default.id
  peer_network = google_compute_network.other.id
}

resource "google_compute_network_peering" "peering2" {
  name         = "peering2"
  network      = google_compute_network.other.id
  peer_network = google_compute_network.default.id
}

# variables
variable "name" {
  description = "Name of the peering."
  type        = string
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

variable "export_custom_routes" {
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
