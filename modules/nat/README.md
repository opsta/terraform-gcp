# Cloud NAT module

Module for create Cloud Nat on Google Cloud

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| google | >= 3.32.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.32.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| drain\_nat\_ips | A list of URLs of the IP resources to be drained. These IPs must be valid static external IPs that have been assigned to the NAT. | `list(string)` | `null` | no |
| icmp\_idle\_timeout\_sec | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set. | `number` | `30` | no |
| log\_config | Configuration for logging on NAT. Object is (enable = Indicates whether or not to export logs. filter = Specifies the desired filtering of logs on this NAT, Possible values are: \* ERRORS\_ONLY \* TRANSLATIONS\_ONLY \* ALL) | <pre>list(object({<br>    enable = bool<br>    filter = string<br>  }))</pre> | `[]` | no |
| min\_ports\_per\_vm | Minimum number of ports allocated to a VM from this NAT. | `number` | `null` | no |
| name | Name of the NAT service. The name must be 1-63 characters long and comply with RFC1035. | `string` | n/a | yes |
| nat\_ip\_allocate\_option | How external IPs should be allocated for this NAT. Valid values are AUTO\_ONLY for only allowing NAT IPs allocated by Google Cloud Platform, or MANUAL\_ONLY for only user-allocated NAT IP addresses. | `string` | n/a | yes |
| nat\_ips | Self-links of NAT IPs. Only valid if natIpAllocateOption is set to MANUAL\_ONLY. | `list(string)` | `null` | no |
| project\_id | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| region | Region where the router resides. | `string` | `null` | no |
| router | The name of the Cloud Router in which this NAT will be configured. | `string` | n/a | yes |
| source\_subnetwork\_ip\_ranges\_to\_nat | How NAT should be configured per Subnetwork. If ALL\_SUBNETWORKS\_ALL\_IP\_RANGES, all of the IP ranges in every Subnetwork are allowed to Nat. If ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, all of the primary IP ranges in every Subnetwork are allowed to Nat. LIST\_OF\_SUBNETWORKS: A list of Subnetworks are allowed to Nat (specified in the field subnetwork below). Note that if this field contains ALL\_SUBNETWORKS\_ALL\_IP\_RANGES or ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, then there should not be any other RouterNat section in any Router for this network in this region. | `string` | n/a | yes |
| subnetwork | One or more subnetwork NAT configurations. Only used if source\_subnetwork\_ip\_ranges\_to\_nat is set to LIST\_OF\_SUBNETWORKS. | <pre>list(object({<br>    name                     = string<br>    source_ip_ranges_to_nat  = string<br>    secondary_ip_range_names = string<br>  }))</pre> | `[]` | no |
| tcp\_established\_idle\_timeout\_sec | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. | `number` | `1200` | no |
| tcp\_transitory\_idle\_timeout\_sec | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. | `number` | `30` | no |
| udp\_idle\_timeout\_sec | Timeout (in seconds) for UDP connections. Defaults to 30s if not set. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | an identifier for the resource with format {{project}}/{{region}}/{{router}}/{{name}} |
| name | Name of the NAT service. |

