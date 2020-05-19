# Resources
resource "random_id" "password" {
  count       = length(var.users)
  byte_length = 10
}

resource "google_sql_user" "users" {
  instance = google_sql_database_instance.master.name
  count    = length(var.users)

  host     = lookup(var.users[count.index], "host", null)
  name     = lookup(var.users[count.index], "name", null)
  password = lookup(var.users[count.index], "password", random_id.password[count.index].hex)
}

# Variables
variable "users" {
  description = "List of map(string) (host ,name, password) to create user for connect database (empty will not created)"
  type        = list(map(string))
  default     = []

  # TODO: check custom validation is experiment feature or not ?
  #   validation {
  #     condition     = length(var.database_password) > 8
  #     error_message = "Password lenght should has more than 8 characters."
  #   }
}

# Outputs
output "users" {
  value       = [for user in google_sql_user.users : "${user.name}:${user.password}:${user.host}"]
  description = "all users created for use to connect database"
}

