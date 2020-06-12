output "id" {
  value       = google_compute_network.vpc.id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "gateway_ipv4" {
  value       = google_compute_network.vpc.gateway_ipv4
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
}

output "self_link" {
  value       = google_compute_network.vpc.self_link
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}
