output "id" {
  description = "an identifier for the resource with format projects/{{project}}/locations/{{region}}/instances/{{name}}"
  value       = google_redis_instance.redis[*].id
}

output "create_time" {
  description = "The time the instance was created in RFC3339 UTC format, accurate to nanoseconds."
  value       = google_redis_instance.redis[*].create_time
}

output "current_location_id" {
  description = "The current zone where the Redis endpoint is placed. For Basic Tier instances, this will always be the same as the [locationId] provided by the user at creation time. For Standard Tier instances, this can be either [locationId] or [alternativeLocationId] and can change after a failover event."
  value       = google_redis_instance.redis[*].current_location_id
}

output "host" {
  description = "Hostname or IP address of the exposed Redis endpoint used by clients to connect to the service."
  value       = google_redis_instance.redis[*].host
}

output "port" {
  description = "The port number of the exposed Redis endpoint."
  value       = google_redis_instance.redis[*].port
}
