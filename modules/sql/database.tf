# Resources
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.master.name
}

# Variables
variable "database_name" {
  description = "Name of database to create (default will use instance name)"
  type        = string
  default     = ""
}

variable "database_charset" {
  description = "Charset for database"
  type        = string
  default     = "utf8"
}

variable "database_collation" {
  description = "Collaction for database"
  type        = string
  default     = "utf8_general_ci"
}

# Outputs
output "database_link" {
  description = "link to refer schema in database"
  value       = google_sql_database.database.self_link
}

output "database_identifier" {
  description = "identifier for the resource"
  value       = google_sql_database.database.id
}
