output "id" {
  value       = google_compute_network.vpc.id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "name" {
  value       = google_compute_network.vpc.name
  description = "Name of VPC"
}

output "gateway_ipv4" {
  value       = google_compute_network.vpc.gateway_ipv4
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
}

output "self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The URI of the created resource."
}

output "subnets_name" {
  value       = google_compute_subnetwork.subnets[*].name
  description = "Name of subnet"
}

output "subnets_id" {
  value       = google_compute_subnetwork.subnets[*].id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "subnets_gateway_address" {
  value       = google_compute_subnetwork.subnets[*].gateway_address
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
}

output "subnets_self_link" {
  value       = google_compute_subnetwork.subnets[*].self_link
  description = "The URI of the created resource."
}

output "subnets_creation_timestamp" {
  value       = google_compute_subnetwork.subnets[*].creation_timestamp
  description = "Creation timestamp in RFC3339 text format."
}
