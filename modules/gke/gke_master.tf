# resources
resource "google_container_cluster" "primary" {
  name        = var.cluster_name
  description = var.description
  project     = var.project_id

  location       = var.location
  node_locations = var.node_locations

  addons_config {
    horizontal_pod_autoscaling {
      disabled = ! var.enable_horizontal_pod_autoscaling
    }
    http_load_balancing {
      disabled = ! var.enable_http_load_balancing
    }
    network_policy_config {
      disabled = ! var.enable_network_policy_config
    }
    cloudrun_config {
      disabled = ! var.enable_cloudrun_config
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
  # cluster_autoscaling {
  #   enabled = var.autoscaling_enabled
  #   resource_limits {
  #     resource_type = var.autoscaling_resource_limit_type
  #     maximum       = var.autoscaling_resource_limit_max
  #     minimum       = var.autoscaling_resource_limit_min
  #   }
  #   # auto_provisioning_defaults {
  #   #   min_cpu_platform = "Intel Haswell" # Beta
  #   #   oauth_scopes    = null
  #   #   service_account = null
  #   # }
  #   # autoscaling_profile = "BALANCED" # Beta
  # }

  # database_encryption { # beta
  #   state    = "ENCRYPTED"
  #   key_name = ""
  # }
  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_binary_authorization = var.enable_binary_authorization
  enable_kubernetes_alpha     = var.enable_kubernetes_alpha
  enable_legacy_abac          = var.enable_legacy_abac
  enable_shielded_nodes       = var.enable_shielded_nodes

  initial_node_count       = 1
  remove_default_node_pool = true

  logging_service = var.logging_service

  ip_allocation_policy {
    cluster_ipv4_cidr_block       = var.pod_range
    cluster_secondary_range_name  = var.secondary_pod_range
    services_ipv4_cidr_block      = var.service_range
    services_secondary_range_name = var.secondary_service_range
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  min_master_version = var.min_master_version
  monitoring_service = var.monitoring_service

  network    = var.vpc_name
  subnetwork = var.subnet_name

  # pod_security_policy_config = null # beta
  # authenticator_groups_config {
  #   security_group = null
  # }

  # FIXME: default value null for block is can't set
  # maintenance_policy {
  #   daily_maintenance_window {
  #     start_time = null
  #   }
  #   recurring_window {
  #     start_time = null
  #     end_time   = null
  #     recurrence = null
  #   }
  # }

  # master_authorized_networks_config {
  #   cidr_blocks {
  #     cidr_block   = null
  #     display_name = null
  #   }
  # }

  # private_cluster_config {
  #   enable_private_nodes    = null
  #   enable_private_endpoint = null
  #   master_ipv4_cidr_block  = null
  # }

  # network_policy {
  #   enabled  = null
  #   provider = null
  # }

  # cluster_telemetry = null # beta
  # release_channel = null # beta
  # resource_usage_export_config = null # beta
  # vertical_pod_autoscaling = null # beta
  # workload_identity_config = null # beta
  # enable_intranode_visibility = null # beta

  # resource_labels = null
}

# variables
variable "cluster_name" {
  description = "name of GKE cluster to provision"
  type        = string
}

variable "description" {
  description = "Description of the cluster."
  type        = string
  default     = null
}

variable "location" {
  description = "Cluster master location. Specific a zone the cluster will be a zonal cluster with a single cluster master. If you specify a region the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well"
  type        = string
  default     = null
}

variable "node_locations" {
  description = "GKE cluster location specific zone willregion will create multi cluster master"
  type        = list(string)
  default     = null
}

variable "default_max_pods_per_node" {
  description = "The default maximum number of pods per node in this cluster. This doesn't work on `routes-based` clusters, clusters that don't have IP Aliasing enabled. See the official documentation for more information."
  type        = number
  default     = null
}

variable "enable_horizontal_pod_autoscaling" {
  description = "The status of the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service."
  type        = bool
  default     = true
}

variable "enable_http_load_balancing" {
  description = "The status of the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster."
  type        = bool
  default     = true
}

variable "enable_network_policy_config" {
  description = "Whether we should enable the network policy addon for the master. This must be enabled in order to enable network policy for the nodes. To enable this, you must also define a network_policy block, otherwise nothing will happen. It can only be disabled if the nodes already do not have network policies enabled."
  type        = bool
  default     = false
}

variable "enable_cloudrun_config" {
  description = "The status of the CloudRun addon."
  type        = bool
  default     = false
}

variable "enable_binary_authorization" {
  description = "Enable Binary Authorization for this cluster. If enabled, all container images will be validated by Google Binary Authorization."
  type        = bool
  default     = false
}

variable "enable_kubernetes_alpha" {
  description = "Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days."
  type        = bool
  default     = false
}

variable "enable_legacy_abac" {
  description = "Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. Defaults to false"
  type        = bool
  default     = false
}

variable "enable_shielded_nodes" {
  description = "Enable Shielded Nodes features on all nodes in this cluster."
  type        = bool
  default     = false
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none. Defaults to logging.googleapis.com/kubernetes"
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "maintenance_policy" {
  description = "The maintenance policy to use for the cluster. Structure is documented below."
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = null
}

variable "cluster_ipv4_cidr" {
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will only work for routes-based clusters, where ip_allocation_policy is not defined."
  type        = string
  default     = null
}

variable "autoscaling_enabled" {
  description = "Whether node auto-provisioning is enabled. Resource limits for cpu and memory must be defined to enable node auto-provisioning"
  type        = bool
  default     = false
}

variable "autoscaling_resource_limit_type" {
  description = "The type of the resource. For example, cpu and memory. See the guide to using Node Auto-Provisioning for a list of types."
  type        = string
  default     = "cpu"
}

variable "autoscaling_resource_limit_min" {
  description = "Minimum amount of the resource in the cluster."
  type        = number
  default     = null
}

variable "autoscaling_resource_limit_max" {
  description = "Maximum amount of the resource in the cluster."
  type        = number
  default     = null
}

variable "pod_range" {
  description = "The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size"
  type        = string
  default     = null
}

variable "service_range" {
  description = "The IP address range of the services IPs in this cluster. Set to blank to have a range chosen with the default size"
  type        = string
  default     = null
}

variable "secondary_pod_range" {
  description = " The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
  default     = null
}

variable "secondary_service_range" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one."
  type        = string
  default     = null
}

variable "min_master_version" {
  description = "The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version"
  type        = string
  default     = null
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com(Legacy Stackdriver), monitoring.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Monitoring), and none."
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

# output
output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}
