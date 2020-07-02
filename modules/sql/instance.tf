# Resources
resource "google_sql_database_instance" "master" {
  name = var.instance_name
  # master_instance_name = ""
  database_version = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))

  settings {
    tier              = var.machine_type
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_autoresize   = var.auto_size
    disk_type         = var.disk_type
    activation_policy = var.activation_policy
    user_labels       = var.labels

    # database_flags      = {}

    backup_configuration {
      enabled    = var.backend_enable
      start_time = var.backup_start_time
    }

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.private_network
      require_ssl     = var.require_ssl

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          expiration_time = authorized_networks.value["expiration_time"]
          name            = authorized_networks.value["name"]
          value           = authorized_networks.value["value"]
        }
      }
    }

    # maintenance_window {
    #   day          = 1
    #   hour         = 0
    #   update_track = "stable"
    # }
  }

  # replica_configuration {
  #   ca_certificate     = ""
  #   client_certificate = ""
  #   client_key         = ""

  #   connect_retry_interval  = 60
  #   dump_file_path          = "gs://bucket/filename"
  #   failover_target         = false
  #   master_heartbeat_period = 5000

  #   username                  = ""
  #   password                  = ""
  #   ssl_cipher                = ""
  #   verify_server_certificate = false
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

variable "ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address. Either ipv4_enabled must be enabled or a private_network must be configured."
  type        = bool
  default     = null
}

variable "private_network" {
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. Either ipv4_enabled must be enabled or a private_network must be configured. This setting can be updated, but it cannot be removed after it is set."
  type        = string
  default     = null
}

variable "require_ssl" {
  description = "True if mysqld should default to REQUIRE X509 for users connecting over IP."
  type        = bool
  default     = null
}

variable "authorized_networks" {
  description = "List of authorized_networks is object contain 3 value. The first is expiration_time = The RFC 3339 formatted date time string indicating when this whitelist expires. The second is name = A name for this whitelist entry. and The last one is value = A CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Must be set even if other two attributes are not for the whitelist to become active."
  type = list(object({
    expiration_time = string
    name            = string
    value           = string
  }))
  default = []
}

# Outputs
