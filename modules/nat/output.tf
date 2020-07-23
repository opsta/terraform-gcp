output "name" {
  description = "Name of the NAT service."
  value       = var.name
}

output "id" {
  description = "an identifier for the resource with format {{project}}/{{region}}/{{router}}/{{name}}"
  value       = google_compute_router_nat.nat.id
}
