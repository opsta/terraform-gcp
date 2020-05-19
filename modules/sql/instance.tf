# Resources
resource "google_sql_database_instance" "master" {
  name = var.instance_name
  # master_instance_name = "${var.instance_name}-master"
  database_version = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))

  settings {
    tier              = var.machine_type
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_autoresize   = var.auto_size
    disk_type         = var.disk_type
    activation_policy = var.activation_policy

    # database_flags = {
    #   name   = ""
    #   values = ""
    # }

    user_labels = var.labels

    backup_configuration {
      enabled    = var.backend_enable
      start_time = var.backup_start_time
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

variable "machine_type" {
  description = "Type of instance to provision database"
  type        = string
  default     = "db-f1-micro"
}

# variable "instance_count" {
#   description = "Number of instance to provision database"
#   type        = number
#   default     = 2
# }

variable "disk_type" {
  description = "The type of data disk: PD_SSD or PD_HDD."
  type        = string
  default     = "PD_SSD"
}

variable "disk_size" {
  description = "The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  type        = number
  default     = 10
}

variable "auto_size" {
  description = "Configuration to increase storage size automatically. Note that future terraform apply calls will attempt to resize the disk to the value specified in disk_size - if this is set, do not set disk_size."
  type        = bool
  default     = true
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).'"
  type        = string
  default     = "ZONAL"
}

variable "activation_policy" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = string
  default     = "ALWAYS"
}

variable "labels" {
  description = "A set of key/value user label pairs to assign to the instance."
  type        = map(string)
  default     = null
}

variable "backup_start_time" {
  description = "HH:MM format time indicating when backup configuration starts."
  type        = string
  default     = "00:00"
}

variable "backend_enable" {
  description = "True if backup configuration is enabled."
  type        = bool
  default     = true
}

# Outputs
