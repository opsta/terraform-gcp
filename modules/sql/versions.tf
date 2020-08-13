terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2.0"
    }
  }
}
