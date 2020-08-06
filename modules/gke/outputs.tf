output "id" {
  value       = google_container_cluster.primary.id
  description = "an identifier for the resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}"
}

output "endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The IP address of this cluster's Kubernetes master."
}

output "instance_group_urls" {
  value       = google_container_cluster.primary.instance_group_urls
  description = "List of instance group URLs which have been assigned to the cluster."
}

output "label_fingerprint" {
  value       = google_container_cluster.primary.label_fingerprint
  description = "The fingerprint of the set of labels for this cluster."
}

output "maintenance_policy_daily_maintenance_window_duration" {
  value       = google_container_cluster.primary.maintenance_policy.*.daily_maintenance_window.0.duration
  description = "Duration of the time window, automatically chosen to be smallest possible in the given scenario. Duration will be in RFC3339 format PTnHnMnS."
}

output "master_auth_client_certificate" {
  value       = google_container_cluster.primary.master_auth.*.client_certificate
  description = "Base64 encoded public certificate used by clients to authenticate to the cluster endpoint."
}

output "master_auth_client_key" {
  value       = google_container_cluster.primary.master_auth.*.client_key
  description = "Base64 encoded private key used by clients to authenticate to the cluster endpoint."
}

output "master_auth_cluster_ca_certificate" {
  value       = google_container_cluster.primary.master_auth.*.cluster_ca_certificate
  description = "Base64 encoded public certificate that is the root of trust for the cluster."
}

output "master_version" {
  value       = google_container_cluster.primary.master_version
  description = "The current version of the master in the cluster. This may be different than the min_master_version set in the config if the master has been updated by GKE."
}

output "services_ipv4_cidr" {
  value       = google_container_cluster.primary.services_ipv4_cidr
  description = "The IP address range of the Kubernetes services in this cluster, in CIDR notation (e.g. 1.2.3.4/29). Service addresses are typically put in the last /16 from the container CIDR."
}

output "node_pool_id" {
  value       = google_container_node_pool.node_pool.*.id
  description = "an identifier for the resource with format {{project}}/{{zone}}/{{cluster}}/{{name}}"
}

output "node_pool_instance_group_urls" {
  value       = google_container_node_pool.node_pool.*.instance_group_urls
  description = "The resource URLs of the managed instance groups associated with this node pool."
}
