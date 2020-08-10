# Redis variables
variable "name" {
  description = "The ID of the instance or a fully qualified identifier for the instance."
  type        = string
}

variable "region" {
  description = "The name of the Redis region of the instance."
  type        = string
  default     = null
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "display_name" {
  description = "An arbitrary and optional user-provided name for the instance."
  type        = string
  default     = null
}

variable "database_type" {
  description = "Type of database to use in memory store service. Must be one of these values: redis, memcached."
  type        = string
  default     = "redis"
}

variable "database_version" {
  description = "Version of database to use in memory store service. Should relate on database_type"
  type        = string
  default     = "4.0"
}

variable "memory_size_gb" {
  description = "Redis memory size in GiB."
  type        = number
  default     = 1
}

variable "location_id" {
  description = "The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For STANDARD_HA tier, instances will be created across two zones for protection against zonal failures. If [alternativeLocationId] is also provided, it must be different from [locationId]."
  type        = string
  default     = null
}

variable "alternative_location_id" {
  description = "Only applicable to STANDARD_HA tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in [locationId]."
  type        = string
  default     = null
}

variable "authorized_network" {
  description = "The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used."
  type        = string
  default     = null
}

variable "is_private" {
  description = "The connection mode of the Redis instance."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Resource labels to represent user provided metadata."
  type        = map(string)
  default     = null
}

variable "redis_configs" {
  description = "Redis configuration parameters, according to http://redis.io/topics/config. Please check Memorystore documentation for the list of supported parameters: https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs"
  type        = map(string)
  default     = null
}

variable "reserved_ip_range" {
  description = "The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused /29 block, for example, 10.0.0.0/29 or 192.168.0.0/29. Ranges must be unique and non-overlapping with existing subnets in an authorized network."
  type        = string
  default     = null
}

variable "enable_ha" {
  description = "Ture if you want to enable highly available primary/replica instances"
  type        = bool
  default     = false
}

variable "address_range" {
  description = "IP address or CIDR range to create Cloud SQL with this address range. Example 10.1.0.0/16 or 10.1.2.3 . Empty will auto create."
  type        = string
  default     = null
}
