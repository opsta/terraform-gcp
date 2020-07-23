module "vpc" {
  source = "../../modules/vpc"

  name        = "example-vpc"
  project_id  = null
  region      = null
  description = null

  routing_mode                    = null
  delete_default_routes_on_create = false

  timeout = "4m"

  subnets = [
    {
      name                     = "example-subnetwork-1"
      ip_cidr_range            = "10.10.0.0/24"
      secondary_ip_range       = null
      private_ip_google_access = null
      log_config               = null
    },
    {
      name                     = "example-subnetwork-2"
      ip_cidr_range            = "10.10.1.0/24"
      secondary_ip_range       = null
      private_ip_google_access = null
      log_config               = null
    }
  ]
}
