module "gke" {
  source = "../../modules/gke"

  name = "test-gke"

  cluster_ipv4_cidr = null

  #   ip_allocation_policy = {
  #     cluster_ipv4_cidr_block       = null
  #     cluster_secondary_range_name  = null
  #     services_ipv4_cidr_block      = null
  #     services_secondary_range_name = null
  #   }

  network    = null
  subnetwork = null

  private_cluster_config = {
    enable_private_nodes    = true
    enable_private_endpoint = null
    master_ipv4_cidr_block  = null
  }

  node_pools = [
    {
      node_count = 3
    }
  ]
}
