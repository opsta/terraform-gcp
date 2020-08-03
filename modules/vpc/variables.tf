variable "name" {
  description = "The VPC name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
  type        = string
}

variable "description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "region" {
  description = "URL of the GCP region for this subnetwork."
  type        = string
  default     = null
}

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

variable "subnets" {
  description = "List of subnetwork configurations in VPC (Follow this args reference https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html)"
  type = list(object({
    name          = string
    ip_cidr_range = string
    secondary_ip_range = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
    private_ip_google_access = string
    log_config = object({
      aggregation_interval = string
      flow_sampling        = string
      meta_data            = string
    })
  }))
  default = []
}
