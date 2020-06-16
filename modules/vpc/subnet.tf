# Resources
resource "google_compute_subnetwork" "subnet" {
  count = var.enabled_subnet == true ? 1 : 0

  ip_cidr_range = var.ip_cidr_range
  name          = "${google_compute_network.vpc.name}-subnet"
  network       = google_compute_network.vpc.name
  description   = var.description
  project       = var.project_id
  region        = var.region

  # purpose = null #beta
  # role = null #beta

  secondary_ip_range = var.secondary_ip_range

  private_ip_google_access = var.private_ip_google_access

  log_config {
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
    metadata             = var.log_meta_data
  }
}

# Variables
variable "enabled_subnet" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}

variable "ip_cidr_range" {
  description = "The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported."
  type        = string
  default     = "10.10.0.0/24"
}

variable "secondary_ip_range" {
  description = "An array of configurations for secondary IP ranges for VM instances contained in this subnetwork. Structure is documented below."
  type = list(object({
    range_name     = string
    ip_cidr_range = string
  }))
  default = null
}

variable "private_ip_google_access" {
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  type        = string
  default     = null
}

variable "log_aggregation_interval" {
  description = "Can only be specified if VPC flow logging for this subnetwork is enabled. Toggles the aggregation interval for collecting flow logs. Increasing the interval time will reduce the amount of generated flow logs for long lasting connections"
  type        = string
  default     = "INTERVAL_5_SEC"
}

variable "log_flow_sampling" {
  description = "Can only be specified if VPC flow logging for this subnetwork is enabled. The value of the field must be in [0, 1]. Set the sampling rate of VPC flow logs within the subnetwork where 1.0 means all collected logs are reported and 0.0 means no logs are reported"
  type        = number
  default     = 0.5
}

variable "log_meta_data" {
  description = "Can only be specified if VPC flow logging for this subnetwork is enabled. Configures whether metadata fields should be added to the reported VPC flow logs. Possible values are: * EXCLUDE_ALL_METADATA * INCLUDE_ALL_METADATA"
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}

# Outputs
output "subnet_name" {
  value       = google_compute_subnetwork.subnet[0].name
  description = "Name of subnet"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet[0].id
  description = "an identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
}

output "subnet_gateway_address" {
  value       = google_compute_subnetwork.subnet[0].gateway_address
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.subnet[0].self_link
  description = "The URI of the created resource."
}

output "subnet_creation_timestamp" {
  value       = google_compute_subnetwork.subnet[0].creation_timestamp
  description = "Creation timestamp in RFC3339 text format."
}
