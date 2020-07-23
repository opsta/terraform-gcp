variable "name" {
  description = "Name of the peering."
  type        = string
}

variable "enable_two_way_peering" {
  description = "Use to create peering for both of network."
  type        = bool
  default     = true
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
