# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE LINUX INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# CONFIGURE OUR GCP CONNECTION
# ------------------------------------------------------------------------------

provider "google" {
  # Create Service Account from this link
  # https://console.cloud.google.com/iam-admin/serviceaccounts/create
  credentials = file("../../gcp.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE LINUX INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

module "instance" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/opsta/terraform-gcp.git//modules/instance?ref=master"
  source             = "../../../modules/instance"
  public_ip_access   = false
  instance_name      = var.instance_name
  gcp_instance_type  = var.gcp_instance_type
  gcp_instance_tags  = var.gcp_instance_tags
  gcp_instance_image = var.gcp_instance_image
  gcp_zone           = var.gcp_zone
  gcp_preemptible    = var.gcp_preemptible
  ssh_username       = var.ssh_username
  ssh_public_key     = var.ssh_public_key
  ssh_port           = var.ssh_port
  rdp_username       = var.rdp_username
  rdp_password       = var.rdp_password
}
