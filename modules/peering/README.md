# VPC Network Peering module

Module for create VPC network peering on Google Cloud

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| google | >= 3.28.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.28.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_two\_way\_peering | Use to create peering for both of network. | `bool` | `true` | no |
| export\_custom\_routes | Whether to export the custom routes to the peer network. | `bool` | `false` | no |
| export\_subnet\_routes\_with\_public\_ip | Whether subnet routes with public IP range are exported. The default value is true, all subnet routes are exported. The IPv4 special-use ranges (https://en.wikipedia.org/wiki/IPv4#Special_addresses) are always exported to peers and are not controlled by this field. | `bool` | `true` | no |
| import\_custom\_routes | Whether to export the custom routes from the peer network. | `bool` | `false` | no |
| import\_subnet\_routes\_with\_public\_ip | Whether subnet routes with public IP range are imported. The default value is false. The IPv4 special-use ranges. | `bool` | `false` | no |
| name | Name of the peering. | `string` | n/a | yes |
| network | The primary network of the peering. | `string` | n/a | yes |
| peer\_network | The peer network in the peering. The peer network may belong to a different project. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_id | an identifier for the resource with format {{network}}/{{name}} |
| network\_state | State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| network\_state\_details | Details about the current state of the peering. |
| peer\_network\_id | an identifier for the resource with format {{network}}/{{name}} |
| peer\_network\_state | State for the peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| peer\_network\_state\_details | Details about the current state of the peering. |

