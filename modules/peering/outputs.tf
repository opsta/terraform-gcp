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
