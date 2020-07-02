# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------



# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_project_id" {
  description = "The GCP project id"
  type        = string
  default     = "opsta-project"
}

variable "gcp_region" {
  description = "The GCP region in which all resources will be created"
  type        = string
  default     = "asia-southeast1"
}

variable "gcp_zone" {
  description = "The GCP zone in which all resources will be created"
  type        = string
  default     = "asia-southeast1-b"
}

variable "instance_name" {
  description = "GCP instance name"
  type        = string
  default     = "example"
}

variable "gcp_instance_type" {
  description = "GCP instance type"
  type        = string
  default     = "n1-standard-2"
}

variable "gcp_instance_tags" {
  description = "list of GCP instance tags"
  type        = list
  default     = ["ping", "rdp"]
}

variable "gcp_instance_image" {
  description = "GCP boot disk image"
  type        = string
  # Grab name from here https://cloud.google.com/compute/docs/images#os-compute-support
  # default     = "ubuntu-os-cloud/ubuntu-2004-lts"
  # default     = "centos-cloud/centos-8"
  # default     = "debian-cloud/debian-10"
  # default     = "rhel-cloud/rhel-8"
  default = "windows-cloud/windows-2012-r2"
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

variable "ssh_public_key" {
  description = "Public Key that can be used to SSH to the Instances"
  type        = string
  default     = ""
}

variable "ssh_username" {
  description = "SSH Username"
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
  default     = "opsta"
}

variable "rdp_password" {
  description = "RDP Administrator password"
  type        = string
  default     = "CHANGEME"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_preemptible" {
  description = "GCP instance preemptible"
  type        = bool
  default     = true
}
