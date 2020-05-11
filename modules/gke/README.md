# GKE module

Module for provision GKE on Google Cloud

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 0.12  |
| google    | >= 3.5.0 |

## Providers

| Name   | Version  |
| ------ | -------- |
| google | >= 3.5.0 |

## Inputs

| Name         | Description                                                         | Type     | Default             | Required |
| ------------ | ------------------------------------------------------------------- | -------- | ------------------- | :------: |
| cluster_name | name of GKE cluster to provision                                    | `string` | `""`                |    no    |
| gke_password | GKE password                                                        | `string` | `""`                |    no    |
| gke_username | GKE username                                                        | `string` | `""`                |    no    |
| machine_type | type of machine to run as workers                                   | `string` | `"n1-standard-1"`   |    no    |
| node_count   | number of GKE nodes per zone                                        | `number` | `1`                 |    no    |
| project_id   | project id to provision GKE                                         | `string` | n/a                 |   yes    |
| region       | region to create VPC                                                | `string` | `"asia-southeast1"` |    no    |
| zone         | zone of GKE cluster [a, b, c] (empty for enable multi zone cluster) | `string` | `""`                |    no    |

## Outputs

| Name                    | Description      |
| ----------------------- | ---------------- |
| kubernetes_cluster_name | GKE Cluster Name |

## Example

```terraform
provider "google" {
  credentials = jsonencode(var.credentials)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "gke" {
  source = "github.com/opsta/terraform-gcp//modules/gke?ref=master"

  project_id   = var.project_id     // project id on GCP
  region       = var.region         // region to provision GKE
  zone         = "a"                // zone to create cluster, empty for enable multi zone cluster
  cluster_name = "test-gke"         // cluster name for GKE
  machine_type = "n1-standard-1"    // instance type for workers
  node_count   = 2                  // number of nodes per zone for workers, multiply with zone if you specific zone value
}
```
