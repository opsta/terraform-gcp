# GKE module

Module for provision GKE on Google Cloud

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| google | >= 3.32.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.32.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addons\_config | The configuration for addons supported by GKE | <pre>object({<br>    horizontal_pod_autoscaling = bool<br>    http_load_balancing        = bool<br>    network_policy_config      = bool<br>    cloudrun_config            = bool<br>  })</pre> | <pre>{<br>  "cloudrun_config": false,<br>  "horizontal_pod_autoscaling": true,<br>  "http_load_balancing": true,<br>  "network_policy_config": false<br>}</pre> | no |
| authenticator\_groups\_config | Configuration for the Google Groups for GKE feature. | <pre>object({<br>    security_group = string<br>  })</pre> | `null` | no |
| cluster\_autoscaling | Per-cluster configuration of Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload. See the guide to using Node Auto-Provisioning for more details. Note: Memory is gigabytes. | <pre>object({<br>    enabled = bool<br>    resource_limits_cpu = object({<br>      maximum = number<br>      minimum = number<br>    })<br>    resource_limits_memory = object({<br>      maximum = number<br>      minimum = number<br>    })<br>    auto_provisioning_defaults = object({<br>      oauth_scopes    = string<br>      service_account = string<br>    })<br>  })</pre> | `null` | no |
| cluster\_ipv4\_cidr | The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will only work for routes-based clusters, where ip\_allocation\_policy is not defined. | `string` | `null` | no |
| database\_encryption | Set database encryption. State is ENCRYPTED or DECRYPTED And key\_name is The key to use to encrypt/decrypt secrets. See the DatabaseEncryption definition for more information. | <pre>object({<br>    state    = string<br>    key_name = string<br>  })</pre> | `null` | no |
| default\_max\_pods\_per\_node | The default maximum number of pods per node in this cluster. This doesn't work on `routes-based` clusters, clusters that don't have IP Aliasing enabled. See the official documentation for more information. | `number` | `null` | no |
| description | Description of the cluster. | `string` | `null` | no |
| enable\_binary\_authorization | Enable Binary Authorization for this cluster. If enabled, all container images will be validated by Google Binary Authorization. | `bool` | `false` | no |
| enable\_kubernetes\_alpha | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. | `bool` | `false` | no |
| enable\_legacy\_abac | Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. Defaults to false | `bool` | `false` | no |
| enable\_shielded\_nodes | Enable Shielded Nodes features on all nodes in this cluster. | `bool` | `false` | no |
| ip\_allocation\_policy | Configuration of cluster IP allocation for VPC-native clusters. Adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based. | <pre>object({<br>    cluster_ipv4_cidr_block       = string<br>    cluster_secondary_range_name  = string<br>    services_ipv4_cidr_block      = string<br>    services_secondary_range_name = string<br>  })</pre> | `null` | no |
| location | The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well | `string` | `null` | no |
| logging\_service | The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none. | `string` | `"logging.googleapis.com/kubernetes"` | no |
| maintenance\_policy | The maintenance policy to use for the cluster. | <pre>object({<br>    daily_maintenance_window_start_time = string<br>    recurring_window_start_time         = string<br>    recurring_window_end_time           = string<br>    recurring_window_recurrence         = string<br>  })</pre> | `null` | no |
| master\_auth | The authentication information for accessing the Kubernetes master. Some values in this block are only returned by the API if your service account has permission to get credentials for your GKE cluster. If you see an unexpected diff removing a username/password or unsetting your client cert, ensure you have the container.clusters.getCredentials permission. | <pre>object({<br>    username                 = string<br>    password                 = string<br>    issue_client_certificate = bool<br>  })</pre> | `null` | no |
| master\_authorized\_networks\_config | The desired configuration options for master authorized networks. Omit the nested cidr\_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists). | <pre>list(object({<br>    cidr_block   = string<br>    display_name = string<br>  }))</pre> | `null` | no |
| min\_master\_version | The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version | `string` | `null` | no |
| monitoring\_service | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com(Legacy Stackdriver), monitoring.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Monitoring), and none. | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| name | name of GKE cluster to provision | `string` | n/a | yes |
| network | The name or self\_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network. | `string` | `null` | no |
| network\_policy | Configuration options for the NetworkPolicy feature. | <pre>object({<br>    provider = string<br>    enabled  = bool<br>  })</pre> | `null` | no |
| node\_locations | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone. | `list(string)` | `null` | no |
| node\_pools | List of node pools configuration (https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_config) | <pre>list(object({<br>    name              = string<br>    name_prefix       = string<br>    location          = string<br>    node_locations    = list(string)<br>    max_pods_per_node = number<br>    version           = string<br><br>    initial_node_count = number<br>    node_count         = number<br><br>    autoscaling = object({<br>      min_node_count = number<br>      max_node_count = number<br>    })<br><br>    management = object({<br>      auto_repair  = string<br>      auto_upgrade = string<br>    })<br><br>    node_config = object({<br>      disk_size_gb = number<br>      disk_type    = string<br><br>      guest_accelerators = list(object({<br>        type  = string<br>        count = number<br>      }))<br><br>      image_type       = string<br>      labels           = map(string)<br>      local_ssd_count  = number<br>      machine_type     = string<br>      metadata         = map(string)<br>      min_cpu_platform = string<br>      oauth_scopes     = list(string)<br>      preemptible      = bool<br>      service_account  = string<br><br>      shielded_instance_config = object({<br>        enable_secure_boot          = bool<br>        enable_integrity_monitoring = bool<br>      })<br><br>      tags = list(string)<br>      taint = list(object({<br>        key    = string<br>        value  = string<br>        effect = string<br>      }))<br>    })<br>  }))</pre> | `[]` | no |
| node\_version | The Kubernetes version on the nodes. Must either be unset or set to the same value as min\_master\_version on create. Defaults to the default version set by GKE which is not necessarily the latest version. This only affects nodes in the default node pool. While a fuzzy version can be specified, it's recommended that you specify explicit versions as Terraform will see spurious diffs when fuzzy versions are used. See the google\_container\_engine\_versions data source's version\_prefix field to approximate fuzzy versions in a Terraform-compatible way. To update nodes in other node pools, use the version attribute on the node pool. | `string` | `null` | no |
| private\_cluster\_config | Configuration for private clusters, clusters with private nodes. | <pre>object({<br>    enable_private_nodes    = bool<br>    enable_private_endpoint = bool<br>    master_ipv4_cidr_block  = string<br>  })</pre> | `null` | no |
| project\_id | project id to provision GKE | `string` | `null` | no |
| region | region to create VPC | `string` | `null` | no |
| resource\_labels | The GCE resource labels (a map of key/value pairs) to be applied to the cluster. | `map(string)` | `null` | no |
| subnetwork | The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | The IP address of this cluster's Kubernetes master. |
| id | an identifier for the resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}} |
| instance\_group\_urls | List of instance group URLs which have been assigned to the cluster. |
| label\_fingerprint | The fingerprint of the set of labels for this cluster. |
| maintenance\_policy\_daily\_maintenance\_window\_duration | Duration of the time window, automatically chosen to be smallest possible in the given scenario. Duration will be in RFC3339 format PTnHnMnS. |
| master\_auth\_client\_certificate | Base64 encoded public certificate used by clients to authenticate to the cluster endpoint. |
| master\_auth\_client\_key | Base64 encoded private key used by clients to authenticate to the cluster endpoint. |
| master\_auth\_cluster\_ca\_certificate | Base64 encoded public certificate that is the root of trust for the cluster. |
| master\_version | The current version of the master in the cluster. This may be different than the min\_master\_version set in the config if the master has been updated by GKE. |
| node\_pool\_id | an identifier for the resource with format {{project}}/{{zone}}/{{cluster}}/{{name}} |
| node\_pool\_instance\_group\_urls | The resource URLs of the managed instance groups associated with this node pool. |
| services\_ipv4\_cidr | The IP address range of the Kubernetes services in this cluster, in CIDR notation (e.g. 1.2.3.4/29). Service addresses are typically put in the last /16 from the container CIDR. |

