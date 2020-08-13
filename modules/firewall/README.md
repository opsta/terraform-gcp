# Firewall rule module

Module for create firewall rule on Google Cloud

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
| allow | List of object for allow firewall rule, Object is contain 2 variable the first is protocal = The IP protocol to which this rule applies. The protocol type is required when creating a firewall rule. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp, ipip), or the IP protocol number.) and second is ports = An optional list of ports to which this rule applies. This field is only applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not specified, this rule applies to connections through any port. Example inputs include: ["22"], ["80","443"], and ["12345-12349"]. | <pre>list(object({<br>    protocol = string<br>    ports    = list(number)<br>  }))</pre> | `[]` | no |
| deny | List of object for deny firewall rule, Object is contain 2 variable the first is protocal = The IP protocol to which this rule applies. The protocol type is required when creating a firewall rule. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp, ipip), or the IP protocol number.) and second is ports = An optional list of ports to which this rule applies. This field is only applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not specified, this rule applies to connections through any port. Example inputs include: ["22"], ["80","443"], and ["12345-12349"]. | <pre>list(object({<br>    protocol = string<br>    ports    = list(number)<br>  }))</pre> | `[]` | no |
| description | An optional description of this resource. Provide this property when you create the resource. | `string` | `null` | no |
| destination\_ranges | If destination ranges are specified, the firewall will apply only to traffic that has destination IP address in these ranges. These ranges must be expressed in CIDR format. Only IPv4 is supported. | `list(string)` | `null` | no |
| direction | Direction of traffic to which this firewall applies; default is INGRESS. Note: For INGRESS traffic, it is NOT supported to specify destinationRanges; For EGRESS traffic, it is NOT supported to specify sourceRanges OR sourceTags. | `string` | `"INGRESS"` | no |
| disabled | Denotes whether the firewall rule is disabled, i.e not applied to the network it is associated with. When set to true, the firewall rule is not enforced and the network behaves as if it did not exist. If this is unspecified, the firewall rule will be enabled. | `bool` | `null` | no |
| enable\_logging | This field denotes whether to enable logging for a particular firewall rule. If logging is enabled, logs will be exported to Stackdriver. | `bool` | `null` | no |
| name | The name of firewall rule | `string` | n/a | yes |
| network | The name of network to create firewall rule | `string` | n/a | yes |
| priority | Priority for this rule. This is an integer between 0 and 65535, both inclusive. When not specified, the value assumed is 1000. Relative priorities determine precedence of conflicting rules. Lower value of priority implies higher precedence (eg, a rule with priority 0 has higher precedence than a rule with priority 1). DENY rules take precedence over ALLOW rules having equal priority. | `number` | `null` | no |
| project | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| source\_ranges | If source ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges. These ranges must be expressed in CIDR format. One or both of sourceRanges and sourceTags may be set. If both properties are set, the firewall will apply to traffic that has source IP address within sourceRanges OR the source IP that belongs to a tag listed in the sourceTags property. The connection does not need to match both properties for the firewall to apply. Only IPv4 is supported. | `list(string)` | `null` | no |
| source\_service\_accounts | If source service accounts are specified, the firewall will apply only to traffic originating from an instance with a service account in this list. Source service accounts cannot be used to control traffic to an instance's external IP address because service accounts are associated with an instance, not an IP address. sourceRanges can be set at the same time as sourceServiceAccounts. If both are set, the firewall will apply to traffic that has source IP address within sourceRanges OR the source IP belongs to an instance with service account listed in sourceServiceAccount. The connection does not need to match both properties for the firewall to apply. sourceServiceAccounts cannot be used at the same time as sourceTags or targetTags. | `list(string)` | `null` | no |
| source\_tags | If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags. Source tags cannot be used to control traffic to an instance's external IP address. Because tags are associated with an instance, not an IP address. One or both of sourceRanges and sourceTags may be set. If both properties are set, the firewall will apply to traffic that has source IP address within sourceRanges OR the source IP that belongs to a tag listed in the sourceTags property. The connection does not need to match both properties for the firewall to apply. | `list(string)` | `null` | no |
| target\_service\_accounts | A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allowed[]. targetServiceAccounts cannot be used at the same time as targetTags or sourceTags. If neither targetServiceAccounts nor targetTags are specified, the firewall rule applies to all instances on the specified network. | `list(string)` | `null` | no |
| target\_tags | A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]. If no targetTags are specified, the firewall rule applies to all instances on the specified network. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| creation\_timestamp | Creation timestamp in RFC3339 text format. |
| id | an identifier for the resource with format projects/{{project}}/global/firewalls/{{name}} |
| name | The name of firewall rule |
| self\_link | The URI of the created resource. |

