# Resources
resource "google_sql_database" "databases" {
  instance = google_sql_database_instance.master.name
  count    = length(var.databases)

  name      = var.databases[count.index].name
  charset   = var.databases[count.index].charset
  collation = var.databases[count.index].collation
}

# Variables

variable "databases" {
  description = "List of databases to create databases (empty will not created)"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

# Outputs
output "databases" {
  description = "All databases information is has status created"
  value       = google_sql_database.databases
}
