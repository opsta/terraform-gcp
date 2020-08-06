module "vpc" {
  source = "../../modules/vpc"

  name = "example-vpc"
  subnets = [
    {
      name                     = "example-subnetwork-1"
      ip_cidr_range            = "10.10.0.0/24"
      secondary_ip_range       = null
      private_ip_google_access = null
      log_config               = null
    }
  ]
}

module "sql" {
  source           = "../../modules/sql"
  name             = "example-sql"
  database_type    = "mysql"
  database_version = "5.7"
  ssl_common_name  = "example"

  is_private = true

  ip_configuration = {
    ipv4_enabled        = false
    private_network     = module.vpc.id
    require_ssl         = null
    authorized_networks = null
  }

  users = [
    {
      host = "%"
      name = "example"
    }
  ]

  databases = [
    {
      name = "example"
    }
  ]
}
