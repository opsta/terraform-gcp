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
