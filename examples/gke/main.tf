module "gke" {
  source = "../../modules/gke"

  name = "test-gke"

  location = var.zone

  cluster_ipv4_cidr = null

  #   ip_allocation_policy = {
  #     cluster_ipv4_cidr_block       = null
  #     cluster_secondary_range_name  = null
  #     services_ipv4_cidr_block      = null
  #     services_secondary_range_name = null
  #   }

  network    = null
  subnetwork = null

  private_cluster_config = null

  node_pools = [
    {
      name               = "example-nodepool"
      name_prefix        = null
      location           = null
      node_locations     = null
      max_pods_per_node  = null
      version            = null
      initial_node_count = null
      node_count         = 2
      autoscaling        = null
      management         = null
      node_config = {
        disk_size_gb       = 10
        disk_type          = "pd-ssd"
        guest_accelerators = null
        image_type         = null
        labels             = null
        local_ssd_count    = null
        machine_type       = "n1-standard-1"
        metadata = {
          disable-legacy-endpoints = "true"
        }
        min_cpu_platform = null
        oauth_scopes = [
          "https://www.googleapis.com/auth/logging.write",
          "https://www.googleapis.com/auth/monitoring"
        ]
        preemptible              = false
        service_account          = null
        shielded_instance_config = null
        tags                     = null
        taint                    = null
      }
    }
  ]
}
