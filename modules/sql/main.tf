resource "random_id" "db_name_suffix" {
  byte_length = 6
}

resource "google_compute_global_address" "private_ip_address" {
  count = var.is_private ? 1 : 0

  name          = "${var.name}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.ip_configuration.private_network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  count = var.is_private ? 1 : 0

  network                 = var.ip_configuration.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address[0].name]
}

resource "google_sql_database_instance" "instance" {
  name                 = "${var.name}-${random_id.db_name_suffix.hex}"
  master_instance_name = var.master_instance_name

  region  = var.region
  project = var.project_id

  database_version = format("%s_%s", upper(var.database_type), upper(replace(replace(var.database_version, ".", "_"), " ", "_")))
  root_password    = var.root_password

  settings {
    tier              = var.machine_type
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_autoresize   = var.auto_size
    disk_type         = var.disk_type
    activation_policy = var.activation_policy
    user_labels       = var.labels

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value["name"]
        value = database_flags.value["value"]
      }
    }

    backup_configuration {
      enabled    = var.backup_start_time == null ? false : true
      start_time = var.backup_start_time
    }

    dynamic "ip_configuration" {
      for_each = var.ip_configuration == null ? [] : [{ "x" : "y" }]
      content {
        ipv4_enabled    = var.ip_configuration.ipv4_enabled
        private_network = var.ip_configuration.private_network
        require_ssl     = var.ip_configuration.require_ssl

        dynamic "authorized_networks" {
          for_each = var.ip_configuration.authorized_networks == null ? [] : var.ip_configuration.authorized_networks
          content {
            expiration_time = authorized_networks.value["expiration_time"]
            name            = authorized_networks.value["name"]
            value           = authorized_networks.value["value"]
          }
        }
      }
    }

    dynamic "location_preference" {
      for_each = var.location_preference == null ? [] : [{ "x" : "y" }]
      content {
        follow_gae_application = var.location_preference.follow_gae_application
        zone                   = var.location_preference.zone
      }
    }

    dynamic "maintenance_window" {
      for_each = var.maintenance_window == null ? [] : [{ "x" : "y" }]
      content {
        day          = var.maintenance_window.day
        hour         = var.maintenance_window.hour
        update_track = var.maintenance_window.is_stable == true ? "stable" : "canary"
      }
    }
  }

  dynamic "replica_configuration" {
    for_each = var.maintenance_window == null ? [] : [{ "x" : "y" }]
    content {
      ca_certificate            = var.maintenance_window.ca_certificate
      client_certificate        = var.maintenance_window.client_certificate
      client_key                = var.maintenance_window.client_key
      connect_retry_interval    = var.maintenance_window.connect_retry_interval
      dump_file_path            = var.maintenance_window.dump_file_path
      failover_target           = var.maintenance_window.failover_target
      master_heartbeat_period   = var.maintenance_window.master_heartbeat_period
      username                  = var.maintenance_window.username
      password                  = var.maintenance_window.password
      ssl_cipher                = var.maintenance_window.ssl_cipher
      verify_server_certificate = var.maintenance_window.verify_server_certificate
    }
  }

  # Beta - encryption_key_name

  depends_on = [
    google_service_networking_connection.private_vpc_connection,
    google_compute_global_address.private_ip_address
  ]
}

resource "google_sql_ssl_cert" "cert" {
  instance    = google_sql_database_instance.instance.name
  project     = var.project_id
  common_name = var.ssl_common_name
}

resource "google_sql_database" "databases" {
  count = length(var.databases)

  instance = google_sql_database_instance.instance.name
  project  = var.project_id

  name      = lookup(var.databases[count.index], "name", null)
  charset   = lookup(var.databases[count.index], "charset", "utf8")
  collation = lookup(var.databases[count.index], "collation", "utf8_general_ci")
}

resource "random_password" "password" {
  count   = length(var.users)
  length  = 10
  special = true
}

resource "google_sql_user" "users" {
  count = length(var.users)

  instance = google_sql_database_instance.instance.name
  project  = var.project_id

  host     = lookup(var.users[count.index], "host", null)
  name     = lookup(var.users[count.index], "name", null)
  password = lookup(var.users[count.index], "password", random_password.password[count.index].result)
}
