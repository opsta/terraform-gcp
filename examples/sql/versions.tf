terraform {
  required_version = ">= 0.12"
  required_providers {
    google = {
      version = ">= 3.34.0"
    }
  }
}

provider "google" {
  credentials = file("../gcp.json")

  project = var.project_id
  region  = var.region
  zone    = var.zone
}
