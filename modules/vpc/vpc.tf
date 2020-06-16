# Resources
resource "google_compute_network" "vpc" {
  name    = var.name
  project = var.project_id

  description                     = var.description
  auto_create_subnetworks         = false
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create

  timeouts {
    create = var.timeout
    update = var.timeout
    delete = var.timeout
  }
}

# Variables
variable "routing_mode" {
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions."
  type        = string
  default     = null
}

variable "delete_default_routes_on_create" {
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false."
  type        = bool
  default     = false
}

variable "timeout" {
  description = "Timeout set for create, delete and update resource. Set in format 60s, 5m, 2h"
  type        = string
  default     = "4m"
}

# Outputs
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
  description = "The URI of the created resource."
}

output "name" {
  value       = google_compute_network.vpc.name
  description = "Name of VPC"
}
