# resources
resource "google_redis_instance" "cache" {
  name         = var.name
  display_name = var.display_name

  count = var.database_type == "redis" ? 1 : 0

  connect_mode   = var.conect_mode
  memory_size_gb = var.memory_size_gb
  tier           = var.ha_mode ? "STANDARD_HA" : "BASIC"
  redis_version  = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))
  redis_configs  = var.redis_configs

  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id

  authorized_network = var.authorized_network
  reserved_ip_range  = var.reserved_ip_range

  labels = var.labels
}

# outputs
output "id" {
  description = "an identifier for the resource with format projects/{{project}}/locations/{{region}}/instances/{{name}}"
  value       = google_redis_instance.cache[*].id
}

output "create_time" {
  description = "The time the instance was created in RFC3339 UTC format, accurate to nanoseconds."
  value       = google_redis_instance.cache[*].create_time
}

output "current_location_id" {
  description = "The current zone where the Redis endpoint is placed. For Basic Tier instances, this will always be the same as the [locationId] provided by the user at creation time. For Standard Tier instances, this can be either [locationId] or [alternativeLocationId] and can change after a failover event."
  value       = google_redis_instance.cache[*].current_location_id
}

output "host" {
  description = "Hostname or IP address of the exposed Redis endpoint used by clients to connect to the service."
  value       = google_redis_instance.cache[*].host
}

output "port" {
  description = "The port number of the exposed Redis endpoint."
  value       = google_redis_instance.cache[*].port
}
