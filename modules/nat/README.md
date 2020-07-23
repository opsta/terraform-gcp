# Cloud Nat module

Module for create Cloud Nat on Google Cloud

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

| Name                               | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Type                                                                                                                          | Default | Required |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| drain_nat_ips                      | A list of URLs of the IP resources to be drained. These IPs must be valid static external IPs that have been assigned to the NAT.                                                                                                                                                                                                                                                                                                                                                                                                                                                | `list(string)`                                                                                                                | `null`  |    no    |
| icmp_idle_timeout_sec              | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `number`                                                                                                                      | `30`    |    no    |
| log_config                         | Configuration for logging on NAT. Object is (enable = Indicates whether or not to export logs. filter = Specifies the desired filtering of logs on this NAT, Possible values are: \* ERRORS_ONLY \* TRANSLATIONS_ONLY \* ALL)                                                                                                                                                                                                                                                                                                                                                    | <pre>list(object({<br> enable = bool<br> filter = string<br> }))</pre>                                                        | `[]`    |    no    |
| min_ports_per_vm                   | Minimum number of ports allocated to a VM from this NAT.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `number`                                                                                                                      | `null`  |    no    |
| name                               | Name of the NAT service. The name must be 1-63 characters long and comply with RFC1035.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`                                                                                                                      | n/a     |   yes    |
| nat_ip_allocate_option             | How external IPs should be allocated for this NAT. Valid values are AUTO_ONLY for only allowing NAT IPs allocated by Google Cloud Platform, or MANUAL_ONLY for only user-allocated NAT IP addresses.                                                                                                                                                                                                                                                                                                                                                                             | `string`                                                                                                                      | n/a     |   yes    |
| nat_ips                            | Self-links of NAT IPs. Only valid if natIpAllocateOption is set to MANUAL_ONLY.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `list(string)`                                                                                                                | `null`  |    no    |
| project_id                         | The ID of the project in which the resource belongs. If it is not provided, the provider project is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `string`                                                                                                                      | `null`  |    no    |
| region                             | Region where the router resides.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `string`                                                                                                                      | `null`  |    no    |
| router                             | The name of the Cloud Router in which this NAT will be configured.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `string`                                                                                                                      | n/a     |   yes    |
| source_subnetwork_ip_ranges_to_nat | How NAT should be configured per Subnetwork. If ALL_SUBNETWORKS_ALL_IP_RANGES, all of the IP ranges in every Subnetwork are allowed to Nat. If ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, all of the primary IP ranges in every Subnetwork are allowed to Nat. LIST_OF_SUBNETWORKS: A list of Subnetworks are allowed to Nat (specified in the field subnetwork below). Note that if this field contains ALL_SUBNETWORKS_ALL_IP_RANGES or ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, then there should not be any other RouterNat section in any Router for this network in this region. | `string`                                                                                                                      | n/a     |   yes    |
| subnetwork                         | One or more subnetwork NAT configurations. Only used if source_subnetwork_ip_ranges_to_nat is set to LIST_OF_SUBNETWORKS.                                                                                                                                                                                                                                                                                                                                                                                                                                                        | <pre>list(object({<br> name = string<br> source_ip_ranges_to_nat = string<br> secondary_ip_range_names = string<br> }))</pre> | `[]`    |    no    |
| tcp_established_idle_timeout_sec   | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `number`                                                                                                                      | `1200`  |    no    |
| tcp_transitory_idle_timeout_sec    | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `number`                                                                                                                      | `30`    |    no    |
| udp_idle_timeout_sec               | Timeout (in seconds) for UDP connections. Defaults to 30s if not set.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `number`                                                                                                                      | `30`    |    no    |

## Outputs

| Name | Description                                                                           |
| ---- | ------------------------------------------------------------------------------------- |
| id   | an identifier for the resource with format {{project}}/{{region}}/{{router}}/{{name}} |
| name | Name of the NAT service.                                                              |

## Example

```terraform
provider "google" {
  credentials = jsonencode(var.credentials)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source = ""github.com/opsta/terraform-gcp//modules/vpc?ref=master""

  name           = "test-vpc"
  enabled_subnet = true
  ip_cidr_range  = "10.10.0.0/24"
}

module "router" {
  source = "github.com/opsta/terraform-gcp//modules/router?ref=master"

  name    = "examaple-router"
  network = module.vpc.id
}

module "nat" {
  source           = "github.com/opsta/terraform-gcp//modules/nat?ref=master"

  name                               = "examaple-nat"
  router                             = module.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config = [{
    enable = true
    filter = "ERRORS_ONLY"
  }]
}
```
