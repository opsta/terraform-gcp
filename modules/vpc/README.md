# VPC module

Module for provision VPC and subnet on Google Cloud

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| delete\_default\_routes\_on\_create | If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false. | `bool` | `false` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `null` | no |
| enabled\_subnet | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| ip\_cidr\_range | The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported. | `string` | `"10.10.0.0/24"` | no |
| log\_aggregation\_interval | Can only be specified if VPC flow logging for this subnetwork is enabled. Toggles the aggregation interval for collecting flow logs. Increasing the interval time will reduce the amount of generated flow logs for long lasting connections | `string` | `"INTERVAL_5_SEC"` | no |
| log\_flow\_sampling | Can only be specified if VPC flow logging for this subnetwork is enabled. The value of the field must be in [0, 1]. Set the sampling rate of VPC flow logs within the subnetwork where 1.0 means all collected logs are reported and 0.0 means no logs are reported | `number` | `0.5` | no |
| log\_meta\_data | Can only be specified if VPC flow logging for this subnetwork is enabled. Configures whether metadata fields should be added to the reported VPC flow logs. Possible values are: \* EXCLUDE\_ALL\_METADATA \* INCLUDE\_ALL\_METADATA | `string` | `"INCLUDE_ALL_METADATA"` | no |
| name | The VPC name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]\*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. | `string` | n/a | yes |
| private\_ip\_google\_access | When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access. | `string` | `null` | no |
| project\_id | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| region | URL of the GCP region for this subnetwork. | `string` | `null` | no |
| routing\_mode | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. | `string` | `null` | no |
| secondary\_ip\_range | An array of configurations for secondary IP ranges for VM instances contained in this subnetwork. Structure is documented below. | <pre>list(object({<br>    range_name     = string<br>    ip_cidr_range = string<br>  }))</pre> | `null` | no |
| timeout | Timeout set for create, delete and update resource. Set in format 60s, 5m, 2h | `string` | `"4m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway\_ipv4 | The gateway address for default routing out of the network. This value is selected by GCP. |
| id | an identifier for the resource with format projects/{{project}}/global/networks/{{name}} |
| name | Name of VPC |
| self\_link | The URI of the created resource. |
| subnet\_creation\_timestamp | Creation timestamp in RFC3339 text format. |
| subnet\_gateway\_address | The gateway address for default routes to reach destination addresses outside this subnetwork. |
| subnet\_id | an identifier for the resource with format projects/{{project}}/global/networks/{{name}} |
| subnet\_name | Name of subnet |
| subnet\_self\_link | The URI of the created resource. |

## Example

```terraform
provider "google" {
  credentials = jsonencode(var.credentials)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source           = "github.com/opsta/terraform-gcp//modules/vpc?ref=master"

  name = "example-network"

  enabled_subnet = true
  ip_cidr_range  = "10.10.0.0/24"

}
```
