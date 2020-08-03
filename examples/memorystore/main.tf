module "redis" {
  source = "../../modules/memorystore"

  name             = "example-redis"
  display_name     = "Example Redis"
  database_type    = "redis"
  database_version = "4.0"
  memory_size_gb   = 1
  enable_ha        = false
  is_private       = true

  authorized_network = "default"
}
