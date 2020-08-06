variable "project_id" {
  description = "project id to provision GKE"
  type        = string
  default     = null
}

variable "region" {
  description = "region to create VPC"
  type        = string
  default     = null
}

variable "name" {
  description = "name of GKE cluster to provision"
  type        = string
}

variable "description" {
  description = "Description of the cluster."
  type        = string
  default     = null
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well"
  type        = string
  default     = null
}

variable "node_locations" {
  description = "The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone."
  type        = list(string)
  default     = null
}

variable "addons_config" {
  description = "The configuration for addons supported by GKE"
  type = object({
    horizontal_pod_autoscaling = bool
    http_load_balancing        = bool
    network_policy_config      = bool
    cloudrun_config            = bool
  })
  default = {
    horizontal_pod_autoscaling = true
    http_load_balancing        = true
    network_policy_config      = false
    cloudrun_config            = false
  }
}

variable "cluster_ipv4_cidr" {
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will only work for routes-based clusters, where ip_allocation_policy is not defined."
  type        = string
  default     = null
}

variable "cluster_autoscaling" {
  description = "Per-cluster configuration of Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload. See the guide to using Node Auto-Provisioning for more details. Note: Memory is gigabytes."
  type = object({
    enabled = bool
    resource_limits_cpu = object({
      maximum = number
      minimum = number
    })
    resource_limits_memory = object({
      maximum = number
      minimum = number
    })
    auto_provisioning_defaults = object({
      oauth_scopes    = string
      service_account = string
    })
  })
  default = null
}

variable "database_encryption" {
  description = "Set database encryption. State is ENCRYPTED or DECRYPTED And key_name is The key to use to encrypt/decrypt secrets. See the DatabaseEncryption definition for more information."
  type = object({
    state    = string
    key_name = string
  })
  default = null
}

variable "default_max_pods_per_node" {
  description = "The default maximum number of pods per node in this cluster. This doesn't work on `routes-based` clusters, clusters that don't have IP Aliasing enabled. See the official documentation for more information."
  type        = number
  default     = null
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

variable "ip_allocation_policy" {
  description = "Configuration of cluster IP allocation for VPC-native clusters. Adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based."
  type = object({
    cluster_ipv4_cidr_block       = string
    cluster_secondary_range_name  = string
    services_ipv4_cidr_block      = string
    services_secondary_range_name = string
  })
  default = null
}

variable "logging_service" {
  description = " The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none."
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "maintenance_policy" {
  description = "The maintenance policy to use for the cluster."
  type = object({
    daily_maintenance_window_start_time = string
    recurring_window_start_time         = string
    recurring_window_end_time           = string
    recurring_window_recurrence         = string
  })
  default = null
}

variable "master_auth" {
  description = "The authentication information for accessing the Kubernetes master. Some values in this block are only returned by the API if your service account has permission to get credentials for your GKE cluster. If you see an unexpected diff removing a username/password or unsetting your client cert, ensure you have the container.clusters.getCredentials permission."
  type = object({
    username                 = string
    password                 = string
    issue_client_certificate = bool
  })
  default = null
}

variable "master_authorized_networks_config" {
  description = "The desired configuration options for master authorized networks. Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = null
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

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
  default     = null
}

variable "network_policy" {
  description = "Configuration options for the NetworkPolicy feature."
  type = object({
    provider = string
    enabled  = bool
  })
  default = null
}

variable "node_version" {
  description = "The Kubernetes version on the nodes. Must either be unset or set to the same value as min_master_version on create. Defaults to the default version set by GKE which is not necessarily the latest version. This only affects nodes in the default node pool. While a fuzzy version can be specified, it's recommended that you specify explicit versions as Terraform will see spurious diffs when fuzzy versions are used. See the google_container_engine_versions data source's version_prefix field to approximate fuzzy versions in a Terraform-compatible way. To update nodes in other node pools, use the version attribute on the node pool."
  type        = string
  default     = null
}

variable "authenticator_groups_config" {
  description = "Configuration for the Google Groups for GKE feature."
  type = object({
    security_group = string
  })
  default = null
}

variable "private_cluster_config" {
  description = "Configuration for private clusters, clusters with private nodes."
  type = object({
    enable_private_nodes    = bool
    enable_private_endpoint = bool
    master_ipv4_cidr_block  = string
  })
  default = null
}

variable "resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster."
  type        = map(string)
  default     = null
}

variable "node_pools" {
  description = "List of node pools configuration (https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_config)"
  type = list(object({
    name              = string
    name_prefix       = string
    location          = string
    node_locations    = list(string)
    max_pods_per_node = number
    version           = string

    initial_node_count = number
    node_count         = number

    autoscaling = object({
      min_node_count = number
      max_node_count = number
    })

    management = object({
      auto_repair  = string
      auto_upgrade = string
    })

    node_config = object({
      disk_size_gb = number
      disk_type    = string

      guest_accelerators = list(object({
        type  = string
        count = number
      }))

      image_type       = string
      labels           = map(string)
      local_ssd_count  = number
      machine_type     = string
      metadata         = map(string)
      min_cpu_platform = string
      oauth_scopes     = list(string)
      preemptible      = bool
      service_account  = string

      shielded_instance_config = object({
        enable_secure_boot          = bool
        enable_integrity_monitoring = bool
      })

      tags = list(string)
      taint = list(object({
        key    = string
        value  = string
        effect = string
      }))
    })
  }))
  default = []
}
