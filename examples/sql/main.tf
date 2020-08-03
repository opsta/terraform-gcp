module "sql" {
  source           = "./modules/sql"
  instance_name    = "example-sql"
  database_type    = "mysql"
  database_version = "5.7"
  ssl_common_name  = "example"

  ipv4_enabled = true

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
