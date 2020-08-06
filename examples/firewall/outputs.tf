output "name" {
  description = "The name of firewall rule"
  value       = module.allow_ssh.name
}

output "id" {
  description = "an identifier for the resource with format projects/{{project}}/global/firewalls/{{name}}"
  value       = module.allow_ssh.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = module.allow_ssh.creation_timestamp
}

output "self_link" {
  description = "The URI of the created resource."
  value       = module.allow_ssh.self_link
}
