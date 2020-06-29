# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------



# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

# variable "gcp_project_id" {
#   description = "The GCP project id"
#   type        = string
#   default     = "opsta-training"
# }

# variable "gcp_region" {
#   description = "The GCP region in which all resources will be created"
#   type        = string
#   default     = "asia-southeast1"
# }

variable "gcp_zone" {
  description = "The GCP zone in which all resources will be created"
  type        = string
  default     = "asia-southeast1-a"
}

variable "instance_name" {
  description = "GCP instance name"
  type        = string
}

variable "gcp_instance_type" {
  description = "GCP instance type"
  type        = string
  default     = "n1-standard-2"
}

variable "gcp_instance_tags" {
  description = "list of GCP instance tags"
  type        = list
  default     = []
}

variable "gcp_instance_boot_disk_size" {
  description = "GCP boot disk size"
  type        = number
  default     = 60
}

variable "gcp_instance_boot_disk_type" {
  description = "GCP boot disk type"
  type        = string
  default     = "pd-standard" #pd-ssd
}

variable "gcp_instance_network" {
  description = "GCP instance network"
  type        = string
  default     = "default"
}

variable "gcp_instance_subnetwork" {
  description = "GCP instance subnetwork"
  type        = string
  default     = "default"
}

variable "gcp_instance_image" {
  description = "GCP boot disk image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

# ---------------------------------------------------------------------------------------------------------------------
# LINUX SSH SECTION
# To configure Linux SSH Key
# ---------------------------------------------------------------------------------------------------------------------

variable "ssh_port" {
  description = "SSH Port"
  type        = number
  default     = 22
}

variable "ssh_username" {
  description = "SSH Username"
  type        = string
  default     = ""
}

variable "ssh_public_key" {
  description = "Public Key that can be used to SSH to the Instances"
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# WINDOWS RDP SECTION
# To configure Windows RDP
# ---------------------------------------------------------------------------------------------------------------------

variable "rdp_username" {
  description = "RDP Administrator username"
  type        = string
  default     = ""
}

variable "rdp_password" {
  description = "RDP Administrator password"
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_preemptible" {
  description = "GCP instance preemptible"
  type        = bool
  default     = false
}

variable "ansible_inventory_path" {
  description = "Path where Ansible Inventory is going to generate"
  type        = string
  default     = "./inventories"
}
