variable "name" {
  description = "The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week."
  type        = string
}

variable "region" {
  description = "The region the instance will sit in. Note, Cloud SQL is not available in all regions - choose from one of the options listed here. A valid region must be provided to use this resource. If a region is not provided in the resource definition, the provider region will be used instead, but this will be an apply-time error for instances if the provider region is not supported with Cloud SQL. If you choose not to provide the region argument for this resource, make sure you understand this."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "database_type" {
  description = "Database type to install. (mysql, postgres, sqlserver)"
  type        = string
  default     = "mysql"
}

variable "database_version" {
  description = "Version database to setup (see also https://cloud.google.com/sql/docs/sqlserver/db-versions)"
  type        = string
  default     = "5.7"
}

variable "root_password" {
  description = "Initial root password. Required for MS SQL Server, ignored by MySQL and PostgreSQL."
  type        = string
  default     = "5.7"
}

variable "master_instance_name" {
  description = "The name of the instance that will act as the master in the replication setup. Note, this requires the master to have binary_log_enabled set, as well as existing backups."
  type        = string
  default     = null
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

variable "database_flags" {
  description = "A set of key/value user label pairs to assign to the instance."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "backup_start_time" {
  description = "If set this variable will enable backup automatically. HH:MM format time indicating when backup configuration starts."
  type        = string
  default     = null
}

variable "ip_configuration" {
  description = "A object to configuration ip policy. document on this (https://www.terraform.io/docs/providers/google/r/sql_database_instance.html)"
  type = object({
    ipv4_enabled    = bool
    private_network = string
    require_ssl     = string
    authorized_networks = list(object({
      expiration_time = string
      name            = string
      value           = string
    }))
  })
  default = null
}

variable "location_preference" {
  description = "Document on this https://www.terraform.io/docs/providers/google/r/sql_database_instance.html"
  type = object({
    follow_gae_application = string
    zone                   = string
  })
  default = null
}

variable "maintenance_window" {
  description = "instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates. The maintenance window is specified in UTC time."
  type = object({
    day       = number
    hour      = number
    is_stable = bool
  })
  default = null
}

variable "replica_configuration" {
  description = "instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates. The maintenance window is specified in UTC time."
  type = object({
    ca_certificate            = string
    client_certificate        = string
    client_key                = string
    connect_retry_interval    = number
    dump_file_path            = string
    failover_target           = bool
    master_heartbeat_period   = number
    username                  = string
    password                  = string
    ssl_cipher                = string
    verify_server_certificate = bool
  })
  default = null
}

variable "ssl_common_name" {
  description = "The common name to be used in the certificate to identify the client"
  type        = string
}

variable "databases" {
  description = "List of map(string) (name ,charset, collation) to create databases (empty will not created)"
  type        = list(map(string))
  default     = []
}

variable "users" {
  description = "List of map(string) (host ,name, password) to create user for connect database (empty will not created)"
  type        = list(map(string))
  default     = []
}
