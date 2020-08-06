output "id" {
  description = "an identifier for the resource with format projects/{{project}}/global/firewalls/{{name}}"
  value       = google_compute_firewall.firewall.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = google_compute_firewall.firewall.creation_timestamp
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_compute_firewall.firewall.self_link
}

output "name" {
  description = "The name of firewall rule"
  value       = var.name
}
