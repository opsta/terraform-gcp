# Resources
resource "google_sql_user" "user" {
  instance = google_sql_database_instance.master.name
  host     = var.database_host
  name     = var.database_user
  password = var.database_password
}

# Variables
variable "database_host" {
  description = "Host that allow user to connect database. Can be IP address. (only mysql)"
  type        = string
  default     = ""
}

variable "database_user" {
  description = "Username for database"
  type        = string
  default     = "opsta"
}

variable "database_password" {
  description = "Password for database"
  type        = string
  default     = ""

  # TODO: check custom validation is experiment feature or not ?
  #   validation {
  #     condition     = length(var.database_password) > 8
  #     error_message = "Password lenght should has more than 8 characters."
  #   }
}

# Outputs
output "username" {
  value       = google_sql_user.user.name
  description = "Name to connect database"
}

output "password" {
  value       = google_sql_user.user.password
  description = "Password to connect database"
}
