# resources
resource "google_compute_router" "router" {
  name        = var.name
  network     = var.network
  description = var.description

  project = var.project_id
  region  = var.region

  dynamic "bgp" {
    for_each = var.asn == null ? [] : [{ "key" = "value" }]
    content {
      asn               = var.asn
      advertise_mode    = var.advertise_mode
      advertised_groups = var.advertised_groups

      dynamic "advertised_ip_ranges" {
        for_each = var.advertised_ip_ranges
        content {
          range       = advertised_ip_ranges.value["range"]
          description = advertised_ip_ranges.value["description"]
        }
      }
    }
  }
}

# variables
variable "name" {
  description = "Name of the resource. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
  type        = string
}

variable "network" {
  description = "A reference to the network to which this router belongs."
  type        = string
}

variable "description" {
  description = "An optional description of this resource."
  type        = string
  default     = null
}

variable "region" {
  description = "Region where the router resides."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "asn" {
  description = "Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN."
  type        = number
  default     = null
}

variable "advertise_mode" {
  description = "User-specified flag to indicate which mode to use for advertisement. Possible values are: * DEFAULT * CUSTOM"
  type        = string
  default     = "DEFAULT"
}

variable "advertised_groups" {
  description = "User-specified list of prefix groups to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These groups will be advertised in addition to any specified prefixes. Leave this field blank to advertise no custom groups. This enum field has the one valid value: ALL_SUBNETS"
  type        = list(string)
  default     = null
}

variable "advertised_ip_ranges" {
  description = "User-specified list of individual IP ranges to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These IP ranges will be advertised in addition to any specified groups. Leave this field blank to advertise no custom IP ranges. Structure is documented below."
  type = list(object({
    range       = string
    description = string
  }))
  default = []
}

# outputs
output "name" {
  description = "Name of the resource."
  value       = var.name
}

output "id" {
  description = "an identifier for the resource with format projects/{{project}}/regions/{{region}}/routers/{{name}}"
  value       = google_compute_router.router.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = google_compute_router.router.creation_timestamp
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_compute_router.router.self_link
}
