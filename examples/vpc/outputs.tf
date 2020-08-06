output "id" {
  value       = module.vpc.id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "name" {
  value       = module.vpc.name
  description = "Name of VPC"
}

output "gateway_ipv4" {
  value       = module.vpc.gateway_ipv4
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
}

output "self_link" {
  value       = module.vpc.self_link
  description = "The URI of the created resource."
}

output "subnets_name" {
  value       = module.vpc.subnets_name
  description = "Name of subnet"
}

output "subnets_id" {
  value       = module.vpc.subnets_id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "subnets_gateway_address" {
  value       = module.vpc.subnets_gateway_address
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
}

output "subnets_self_link" {
  value       = module.vpc.subnets_self_link
  description = "The URI of the created resource."
}

output "subnets_creation_timestamp" {
  value       = module.vpc.subnets_creation_timestamp
  description = "Creation timestamp in RFC3339 text format."
}
