# Network Peering module

Module for create peering on Google Cloud

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 0.12   |
| google    | >= 3.28.0 |

## Providers

| Name   | Version   |
| ------ | --------- |
| google | >= 3.28.0 |

## Inputs

| Name                                | Description                                                                                                                                                                                                                                                               | Type     | Default | Required |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| export_custom_routes                | Whether to export the custom routes from the peer network.                                                                                                                                                                                                                | `bool`   | `false` |    no    |
| export_subnet_routes_with_public_ip | Whether subnet routes with public IP range are exported. The default value is true, all subnet routes are exported. The IPv4 special-use ranges (https://en.wikipedia.org/wiki/IPv4#Special_addresses) are always exported to peers and are not controlled by this field. | `bool`   | `true`  |    no    |
| import_subnet_routes_with_public_ip | Whether subnet routes with public IP range are imported. The default value is false. The IPv4 special-use ranges.                                                                                                                                                         | `bool`   | `false` |    no    |
| name                                | Name of the peering.                                                                                                                                                                                                                                                      | `string` | n/a     |   yes    |
| network                             | The primary network of the peering.                                                                                                                                                                                                                                       | `string` | n/a     |   yes    |
| peer_network                        | The peer network in the peering. The peer network may belong to a different project.                                                                                                                                                                                      | `string` | n/a     |   yes    |

## Outputs

| Name                       | Description                                                                                                                        |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| network_id                 | an identifier for the resource with format {{network}}/{{name}}                                                                    |
| network_state              | State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| network_state_details      | Details about the current state of the peering.                                                                                    |
| peer_network_id            | an identifier for the resource with format {{network}}/{{name}}                                                                    |
| peer_network_state         | State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| peer_network_state_details | Details about the current state of the peering.                                                                                    |

## Example

```terraform
provider "google" {
  credentials = jsonencode(var.credentials)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "peering" {
  source       = "github.com/opsta/terraform-gcp//modules/peering?ref=master"
  name         = "example-peering"
  network      = "vpc-1"
  peer-network = "vpc-2"
}
```
