output "instance_name" {
  description = "Instance Name"
  value       = var.instance_name
}

output "public_ip" {
  description = "Instance Public IP"
  value       = module.instance.public_ip
}

output "private_ip" {
  description = "Instance Private IP"
  value       = module.instance.private_ip
}

output "ssh_port" {
  description = "Instance SSH Port"
  value       = var.ssh_port
}

output "ssh_username" {
  description = "Instance SSH Username"
  value       = var.ssh_username
}

output "rdp_username" {
  description = "Instance RDP Username"
  value       = var.rdp_username
}

output "rdp_password" {
  description = "Instance RDP Password"
  value       = var.rdp_password
}
