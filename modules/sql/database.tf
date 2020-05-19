# Resources
resource "google_sql_database" "databases" {
  instance = google_sql_database_instance.master.name
  count    = length(var.databases)

  name      = lookup(var.databases[count.index], "name", null)
  charset   = lookup(var.databases[count.index], "charset", "utf8")
  collation = lookup(var.databases[count.index], "collation", "utf8_general_ci")
}

# Variables

variable "databases" {
  description = "List of map(string) (name ,charset, collation) to create databases (empty will not created)"
  type        = list(map(string))
  default     = []
}

# Outputs
output "databases" {
  description = "All databases information is has status created"
  value       = google_sql_database.databases
}
