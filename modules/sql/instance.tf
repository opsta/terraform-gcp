# Resources
resource "google_sql_database_instance" "master" {
  name = var.instance_name
  # master_instance_name = "${var.instance_name}-master"

  # root_password = var.root_password

  database_version = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))

  settings {
    tier              = var.machince_type
    availability_type = "ZONAL"
    disk_size         = 10
    disk_autoresize   = true
    disk_type         = "PD_SSD"

    # user_labels = {
    #   "test" : "test"
    #   "test1" : "test1"
    # }

    # dynamic "database_flags" {
    #   for_each = google_compute_instance.apps
    #   iterator = apps

    #   content {
    #     name  = "test"
    #     value = "test"
    #   }
    # }

    backup_configuration {
      enabled    = true
      start_time = "00:00"
    }
  }

  # replica_configuration {

  # }
}

# Variables
variable "instance_name" {
  description = "instance name to create in cloud sql"
  type        = string
}

variable "database_type" {
  description = "Database type to install. (mysql, postgres, sqlserver)"
  type        = string
  default     = "mysql"
}

variable "database_version" {
  description = "version of database to install (see also https://cloud.google.com/sql/docs/sqlserver/db-versions)"
  type        = string
  default     = "5.7"
}

variable "machince_type" {
  description = "Type of instance to provision database"
  type        = string
  default     = "db-f1-micro"
}

variable "instance_count" {
  description = "Type of instance to provision database"
  type        = number
  default     = 2
}

variable "root_password" {
  description = "Password for root user. User be postgres in postgres database"
  type        = string
}

# Outputs
