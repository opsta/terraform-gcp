# Network VPC module

Module for provision VPC and subnet on Google Cloud

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| google | >= 3.34.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.34.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| delete\_default\_routes\_on\_create | If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false. | `bool` | `false` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `null` | no |
| name | The VPC name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]\*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| region | URL of the GCP region for this subnetwork. | `string` | `null` | no |
| routing\_mode | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. | `string` | `null` | no |
| subnets | List of subnetwork configurations in VPC (Follow this args reference https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html) | <pre>list(object({<br>    name          = string<br>    ip_cidr_range = string<br>    secondary_ip_range = list(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    }))<br>    private_ip_google_access = bool<br>    log_config = object({<br>      aggregation_interval = string<br>      flow_sampling        = string<br>      meta_data            = string<br>    })<br>  }))</pre> | `[]` | no |
| timeout | Timeout set for create, delete and update resource. Set in format 60s, 5m, 2h | `string` | `"4m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway\_ipv4 | The gateway address for default routing out of the network. This value is selected by GCP. |
| id | an identifier for the resource with format projects/{{project}}/global/networks/{{name}} |
| name | Name of VPC |
| self\_link | The URI of the created resource. |
| subnets\_creation\_timestamp | Creation timestamp in RFC3339 text format. |
| subnets\_gateway\_address | The gateway address for default routes to reach destination addresses outside this subnetwork. |
| subnets\_id | an identifier for the resource with format projects/{{project}}/global/networks/{{name}} |
| subnets\_name | Name of subnet |
| subnets\_self\_link | The URI of the created resource. |

