# # Resources
# resource "google_sql_source_representation_instance" "instance" {
#   name             = var.instance_name
#   region           = var.region
#   database_version = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))
#   host             = var.database_host
#   port             = var.database_port
# }

# # Variables
# variable "database_port" {
#   description = "Port for connect to database"
#   type        = number
#   default     = 3306
# }

# variable "region" {
#   description = "region"
#   type        = string
# }

# # Outputs
# output "representation_id" {
#   value = google_sql_source_representation_instance.instance.id
# }
