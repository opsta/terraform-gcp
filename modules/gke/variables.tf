variable "project_id" {
  description = "project id to provision GKE"
  type        = string
  default     = null
}

variable "region" {
  description = "region to create VPC"
  type        = string
  default     = null
}
