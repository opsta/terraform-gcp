terraform {
  required_version = ">= 0.12"
  required_providers {
    google = {
      version = ">= 3.21.0"
    }
  }
}

# https://www.terraform.io/docs/providers/google/r/sql_source_representation_instance.html
# resource "google_sql_source_representation_instance" "instance" {
#   name             = "my-instance"
#   region           = "us-central1"
#   database_version = "MYSQL_5_7"
#   host             = "10.20.30.40"
#   port             = 3306
# }
