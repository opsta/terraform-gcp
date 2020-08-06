resource "google_container_cluster" "primary" {
  name        = var.name
  description = var.description
  project     = var.project_id

  location       = var.location
  node_locations = var.node_locations

  addons_config {
    horizontal_pod_autoscaling {
      disabled = ! var.addons_config.horizontal_pod_autoscaling
    }
    http_load_balancing {
      disabled = ! var.addons_config.http_load_balancing
    }
    network_policy_config {
      disabled = ! var.addons_config.network_policy_config
    }
    cloudrun_config {
      disabled = ! var.addons_config.cloudrun_config
    }
    # TODO: Beta
    # istio_config {
    #   disabled = true
    #   auth = ""
    # }
    # dns_cache_config {
    #   enabled = true
    # }
    # gce_persistent_disk_csi_driver_config {
    #   enabled = false
    # }
    # kalm_config {
    #   enabled = false
    # }
    # config_connector_config {
    #   enabled = false
    # }
  }

  cluster_ipv4_cidr = var.cluster_ipv4_cidr

  dynamic "cluster_autoscaling" {
    for_each = var.cluster_autoscaling == null ? [] : [{ "key" = "value" }]
    content {
      enabled = var.cluster_autoscaling.enabled

      dynamic "resource_limits" {
        for_each = var.cluster_autoscaling.resource_limits_cpu == null ? [] : [{ "key" = "value" }]
        content {
          resource_type = "cpu"
          minimum       = var.cluster_autoscaling.resource_limits_cpu.minimum
          maximum       = var.cluster_autoscaling.resource_limits_cpu.maximum
        }
      }

      dynamic "resource_limits" {
        for_each = var.cluster_autoscaling.resource_limits_memory == null ? [] : [{ "key" = "value" }]
        content {
          resource_type = "memory"
          minimum       = var.cluster_autoscaling.resource_limits_memory.minimum
          maximum       = var.cluster_autoscaling.resource_limits_memory.maximum
        }
      }

      dynamic "auto_provisioning_defaults" {
        for_each = var.cluster_autoscaling.auto_provisioning_defaults == null ? [] : [{ "key" = "value" }]
        content {
          oauth_scopes    = var.cluster_autoscaling.auto_provisioning_defaults.oauth_scopes
          service_account = var.cluster_autoscaling.auto_provisioning_defaults.service_account
        }
      }
    }
  }

  dynamic "database_encryption" {
    for_each = var.database_encryption == null ? [] : [{ "key" = "value" }]
    content {
      state    = var.database_encryption.state
      key_name = var.database_encryption.key_name
    }
  }

  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_binary_authorization = var.enable_binary_authorization
  enable_kubernetes_alpha     = var.enable_kubernetes_alpha

  # TODO: beta - enable_tpu

  enable_legacy_abac    = var.enable_legacy_abac
  enable_shielded_nodes = var.enable_shielded_nodes

  # Don't Create Default Node pool And not provide node_config for defalt node pool
  initial_node_count       = 1
  remove_default_node_pool = true

  dynamic "ip_allocation_policy" {
    for_each = var.ip_allocation_policy == null ? [] : [{ "key" = "value" }]
    content {
      cluster_ipv4_cidr_block       = var.ip_allocation_policy.cluster_ipv4_cidr_block
      cluster_secondary_range_name  = var.ip_allocation_policy.cluster_secondary_range_name
      services_ipv4_cidr_block      = var.ip_allocation_policy.services_ipv4_cidr_block
      services_secondary_range_name = var.ip_allocation_policy.services_secondary_range_name
    }
  }

  # TODO: beta - networking_mode

  logging_service = var.logging_service

  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy == null ? [] : [{ "key" = "value" }]
    content {
      daily_maintenance_window {
        start_time = var.maintenance_policy.daily_maintenance_window_start_time
      }
      recurring_window {
        start_time = var.maintenance_policy.recurring_window_start_time
        end_time   = var.maintenance_policy.recurring_window_end_time
        recurrence = var.maintenance_policy.recurring_window_recurrence
      }
    }
  }

  dynamic "master_auth" {
    for_each = var.master_auth == null ? [] : [{ "key" = "value" }]
    content {
      username = var.master_auth.username
      password = var.master_auth.password
      client_certificate_config {
        issue_client_certificate = var.master_auth.issue_client_certificate
      }
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks_config == null ? [] : [{ "key" = "value" }]
    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks_config
        content {
          cidr_block   = cidr_blocks.cidr_block
          display_name = cidr_blocks.display_name
        }
      }
    }
  }

  min_master_version = var.min_master_version
  monitoring_service = var.monitoring_service

  network    = var.network
  subnetwork = var.subnetwork

  dynamic "network_policy" {
    for_each = var.network_policy == null ? [] : [{ "key" = "value" }]
    content {
      provider = var.network_policy.provider
      enabled  = var.network_policy.enabled
    }
  }

  node_version = var.node_version

  # TODO: Beta - pod_security_policy_config

  dynamic "authenticator_groups_config" {
    for_each = var.authenticator_groups_config == null ? [] : [{ "x" : "y" }]
    content {
      security_group = var.authenticator_groups_config.security_group
    }
  }

  dynamic "private_cluster_config" {
    for_each = var.private_cluster_config == null ? [] : [{ "x" : "y" }]
    content {
      enable_private_nodes    = var.private_cluster_config.enable_private_nodes
      enable_private_endpoint = var.private_cluster_config.enable_private_endpoint
      master_ipv4_cidr_block  = var.private_cluster_config.master_ipv4_cidr_block
    }
  }

  # TODO: Beta - cluster_telemetry
  # TODO: Beta - release_channel

  resource_labels = var.resource_labels

  # TODO: Beta - resource_usage_export_config
  # TODO: Beta - vertical_pod_autoscaling
  # TODO: Beta - workload_identity_config
  # TODO: Beta - enable_intranode_visibility
  # TODO: Beta - default_snat_status
}

resource "google_container_node_pool" "node_pool" {
  count = length(var.node_pools)

  cluster            = google_container_cluster.primary.name
  name               = var.node_pools[count.index].name
  name_prefix        = var.node_pools[count.index].name_prefix
  location           = var.node_pools[count.index].location == null ? google_container_cluster.primary.location : var.node_pools[count.index].location
  node_locations     = var.node_pools[count.index].node_locations
  version            = var.node_pools[count.index].version
  initial_node_count = var.node_pools[count.index].initial_node_count
  node_count         = var.node_pools[count.index].node_count

  dynamic "autoscaling" {
    for_each = var.node_pools[count.index].autoscaling == null ? [] : [{ "x" : "y" }]
    content {
      min_node_count = var.node_pools[count.index].autoscaling.min_node_count
      max_node_count = var.node_pools[count.index].autoscaling.max_node_count
    }
  }

  dynamic "management" {
    for_each = var.node_pools[count.index].management == null ? [] : [{ "x" : "y" }]
    content {
      auto_repair  = var.node_pools[count.index].management.auto_repair
      auto_upgrade = var.node_pools[count.index].management.auto_upgrade
    }
  }

  dynamic "node_config" {
    for_each = var.node_pools[count.index].node_config == null ? [] : [{ "x" : "y" }]
    content {
      disk_size_gb = var.node_pools[count.index].node_config.disk_size_gb
      disk_type    = var.node_pools[count.index].node_config.disk_type

      dynamic "guest_accelerator" {
        for_each = var.node_pools[count.index].node_config.guest_accelerators == null ? [] : var.node_pools[count.index].node_config.guest_accelerators
        content {
          type  = guest_accelerator.type
          count = guest_accelerator.count
        }
      }

      image_type       = var.node_pools[count.index].node_config.image_type
      labels           = var.node_pools[count.index].node_config.labels
      local_ssd_count  = var.node_pools[count.index].node_config.local_ssd_count
      machine_type     = var.node_pools[count.index].node_config.machine_type
      metadata         = var.node_pools[count.index].node_config.metadata
      min_cpu_platform = var.node_pools[count.index].node_config.min_cpu_platform
      oauth_scopes     = var.node_pools[count.index].node_config.oauth_scopes
      preemptible      = var.node_pools[count.index].node_config.preemptible
      service_account  = var.node_pools[count.index].node_config.service_account

      dynamic "shielded_instance_config" {
        for_each = var.node_pools[count.index].node_config.shielded_instance_config == null ? [] : [{ "x" : "y" }]
        content {
          enable_secure_boot          = var.node_pools[count.index].node_config.shielded_instance_config.enable_secure_boot
          enable_integrity_monitoring = var.node_pools[count.index].node_config.shielded_instance_config.enable_integrity_monitoring
        }
      }

      tags = var.node_pools[count.index].node_config.tags

      dynamic "taint" {
        for_each = var.node_pools[count.index].node_config.taint == null ? [] : var.node_pools[count.index].node_config.taint
        content {
          key    = var.node_pools[count.index].node_config.taint.key
          value  = var.node_pools[count.index].node_config.taint.value
          effect = var.node_pools[count.index].node_config.taint.effect
        }
      }

      # TODO: beta - sandbox_config
      # TODO: beta - boot_disk_kms_key
      # TODO: beta - workload_metadata_config
    }
  }

  # TODO: beta - upgrade_settings
}
