variable "name" {
  description = "Name of the NAT service. The name must be 1-63 characters long and comply with RFC1035."
  type        = string
}

variable "nat_ip_allocate_option" {
  description = "How external IPs should be allocated for this NAT. Valid values are AUTO_ONLY for only allowing NAT IPs allocated by Google Cloud Platform, or MANUAL_ONLY for only user-allocated NAT IP addresses."
  type        = string
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "How NAT should be configured per Subnetwork. If ALL_SUBNETWORKS_ALL_IP_RANGES, all of the IP ranges in every Subnetwork are allowed to Nat. If ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, all of the primary IP ranges in every Subnetwork are allowed to Nat. LIST_OF_SUBNETWORKS: A list of Subnetworks are allowed to Nat (specified in the field subnetwork below). Note that if this field contains ALL_SUBNETWORKS_ALL_IP_RANGES or ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, then there should not be any other RouterNat section in any Router for this network in this region."
  type        = string
}

variable "router" {
  description = " The name of the Cloud Router in which this NAT will be configured."
  type        = string
}

variable "nat_ips" {
  description = "Self-links of NAT IPs. Only valid if natIpAllocateOption is set to MANUAL_ONLY."
  type        = list(string)
  default     = null
}

variable "drain_nat_ips" {
  description = "A list of URLs of the IP resources to be drained. These IPs must be valid static external IPs that have been assigned to the NAT."
  type        = list(string)
  default     = null
}

variable "subnetwork" {
  description = "One or more subnetwork NAT configurations. Only used if source_subnetwork_ip_ranges_to_nat is set to LIST_OF_SUBNETWORKS."
  type = list(object({
    name                     = string
    source_ip_ranges_to_nat  = string
    secondary_ip_range_names = string
  }))
  default = []
}

variable "min_ports_per_vm" {
  description = "Minimum number of ports allocated to a VM from this NAT."
  type        = number
  default     = null
}

variable "udp_idle_timeout_sec" {
  description = "Timeout (in seconds) for UDP connections. Defaults to 30s if not set."
  type        = number
  default     = 30
}

variable "icmp_idle_timeout_sec" {
  description = "Timeout (in seconds) for ICMP connections. Defaults to 30s if not set."
  type        = number
  default     = 30
}

variable "tcp_established_idle_timeout_sec" {
  description = "Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set."
  type        = number
  default     = 1200
}

variable "tcp_transitory_idle_timeout_sec" {
  description = "Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set."
  type        = number
  default     = 30
}

variable "log_config" {
  description = "Configuration for logging on NAT. Object is (enable = Indicates whether or not to export logs. filter = Specifies the desired filtering of logs on this NAT, Possible values are: * ERRORS_ONLY * TRANSLATIONS_ONLY * ALL)"
  type = list(object({
    enable = bool
    filter = string
  }))
  default = []
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
