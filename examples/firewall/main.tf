module "allow_ssh" {
  source = "../../modules/firewall"

  name    = "allow-ssh"
  network = module.vpc.name

  allow = [{
    protocol = "tcp"
    ports    = [22]
  }]
}

module "vpc" {
  source = "../../modules/vpc"
  name   = "example-vpc"
}
