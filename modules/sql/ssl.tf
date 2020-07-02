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
output "sha1_fingerprint" {
  description = "The SHA1 Fingerprint of the certificate"
  value       = google_sql_ssl_cert.cert.sha1_fingerprint
}

output "private_key" {
  description = "The private key associated with the client certificate"
  value       = google_sql_ssl_cert.cert.private_key
}

output "server_ca_cert" {
  description = "The CA cert of the server this client cert was generated from"
  value       = google_sql_ssl_cert.cert.server_ca_cert
}

output "cert" {
  description = "The actual certificate data for this client certificate"
  value       = google_sql_ssl_cert.cert.cert
}

output "cert_serial_number" {
  description = "The serial number extracted from the certificate data"
  value       = google_sql_ssl_cert.cert.cert_serial_number
}

output "create_time" {
  description = "The time when the certificate was created in RFC 3339 format, for example 2012-11-15T16:19:00.094Z"
  value       = google_sql_ssl_cert.cert.create_time
}

output "expiration_time" {
  description = "The time when the certificate expires in RFC 3339 format, for example 2012-11-15T16:19:00.094Z"
  value       = google_sql_ssl_cert.cert.expiration_time
}
