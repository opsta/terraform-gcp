output "self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database_instance.instance.self_link
}

output "connection_name" {
  description = " The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_sql_database_instance.instance.connection_name
}

output "service_account_email_address" {
  description = "The service account email address assigned to the instance."
  value       = google_sql_database_instance.instance.service_account_email_address
}

output "ip_address_ip_address" {
  description = "The IPv4 address assigned."
  value       = google_sql_database_instance.instance.ip_address.*.ip_address
}

output "ip_address_time_to_retire" {
  description = "The time this IP address will be retired, in RFC 3339 format."
  value       = google_sql_database_instance.instance.ip_address.*.time_to_retire
}

output "ip_address_type" {
  description = "The type of this IP address."
  value       = google_sql_database_instance.instance.ip_address.*.type
}

output "first_ip_address" {
  description = "The first IPv4 address of any type assigned. This is to support accessing the first address in the list in a terraform output when the resource is configured with a count."
  value       = google_sql_database_instance.instance.first_ip_address
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = google_sql_database_instance.instance.public_ip_address
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config."
  value       = google_sql_database_instance.instance.private_ip_address
}

output "settings_version" {
  description = "Used to make sure changes to the settings block are atomic."
  value       = google_sql_database_instance.instance.settings.*.version
}

output "server_ca_cert_cert" {
  description = "The CA Certificate used to connect to the SQL Instance via SSL."
  value       = google_sql_database_instance.instance.server_ca_cert.*.cert
}

output "server_ca_cert_common_name" {
  description = "The CN valid for the CA Cert."
  value       = google_sql_database_instance.instance.server_ca_cert.*.common_name
}

output "server_ca_cert_create_time" {
  description = "Creation time of the CA Cert."
  value       = google_sql_database_instance.instance.server_ca_cert.*.create_time
}

output "server_ca_cert_expiration_time" {
  description = "Expiration time of the CA Cert."
  value       = google_sql_database_instance.instance.server_ca_cert.*.expiration_time
}

output "server_ca_cert_sha1_fingerprint" {
  description = "SHA Fingerprint of the CA Cert."
  value       = google_sql_database_instance.instance.server_ca_cert.*.sha1_fingerprint
}

output "databases_name" {
  description = "All databases information is has status created"
  value       = [for db in google_sql_database.databases : "Name: ${db.name} Charset:${db.charset} Collation: ${db.collation}"]
}

output "databases_id" {
  description = "an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value       = google_sql_database.databases.*.id
}

output "databases_self_link" {
  description = "The URI of the created resource."
  value       = google_sql_database.databases.*.self_link
}

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

output "users" {
  value       = [for user in google_sql_user.users : "User: ${user.name} Pass:${user.password} Allow-Host: ${user.host}"]
  description = "all users created for use to connect database"
}
