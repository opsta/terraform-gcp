output "instance_name" {
  description = "Instance Name"
  value       = var.instance_name
}

output "public_ip" {
  description = "Instance Public IP"
  value       = google_compute_instance.instance.network_interface.0.access_config.*.nat_ip
}

output "private_ip" {
  description = "Instance Private IP"
  value       = google_compute_instance.instance.network_interface.*.network_ip
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
