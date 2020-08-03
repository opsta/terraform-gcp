terraform {
  experiments      = [variable_validation]
  required_version = ">= 0.12"
  required_providers {
    google = {
      version = ">= 3.32.0"
    }
  }
}
