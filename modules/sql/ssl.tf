# Resources
resource "google_sql_ssl_cert" "cert" {
  instance    = google_sql_database_instance.master.name
  common_name = var.ssl_common_name
}

# Variables
variable "ssl_common_name" {
  description = "The common name to be used in the certificate to identify the client"
  type        = string
}

# Outputs
data "google_sql_ca_certs" "ca_certs" {
  instance = google_sql_database_instance.master.name
}

locals {
  furthest_expiration_time = reverse(sort([for k, v in data.google_sql_ca_certs.ca_certs.certs : v.expiration_time]))[0]
  latest_ca_cert           = [for v in data.google_sql_ca_certs.ca_certs.certs : v.cert if v.expiration_time == local.furthest_expiration_time]
}

output "certs" {
  value       = local.latest_ca_cert
  description = "List of server CA certificates for the instance"
  sensitive   = true
}

output "active_ca_version" {
  value       = data.google_sql_ca_certs.ca_certs.active_version
  description = "SHA1 fingerprint of the currently active CA certificate."
}
