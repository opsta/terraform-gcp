## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | name of gke cluster | `string` | `""` | no |
| gke\_password | gke password | `string` | `""` | no |
| gke\_username | gke username | `string` | `""` | no |
| machine\_type | type of machine to run as worker | `string` | `"n1-standard-1"` | no |
| node\_count | number of gke nodes per zone | `number` | `1` | no |
| project\_id | project id | `string` | n/a | yes |
| region | region | `string` | `"asia-southeast1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kubernetes\_cluster\_name | GKE Cluster Name |

