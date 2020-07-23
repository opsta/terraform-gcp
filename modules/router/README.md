# Cloud Router module

Module for create Cloud Router on Google Cloud

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
| advertise\_mode | User-specified flag to indicate which mode to use for advertisement. Possible values are: \* DEFAULT \* CUSTOM | `string` | `"DEFAULT"` | no |
| advertised\_groups | User-specified list of prefix groups to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These groups will be advertised in addition to any specified prefixes. Leave this field blank to advertise no custom groups. This enum field has the one valid value: ALL\_SUBNETS | `list(string)` | `null` | no |
| advertised\_ip\_ranges | User-specified list of individual IP ranges to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These IP ranges will be advertised in addition to any specified groups. Leave this field blank to advertise no custom IP ranges. Structure is documented below. | <pre>list(object({<br>    range       = string<br>    description = string<br>  }))</pre> | `[]` | no |
| asn | Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN. | `number` | `null` | no |
| description | An optional description of this resource. | `string` | `null` | no |
| name | Name of the resource. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]\*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. | `string` | n/a | yes |
| network | A reference to the network to which this router belongs. | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| region | Region where the router resides. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| creation\_timestamp | Creation timestamp in RFC3339 text format. |
| id | an identifier for the resource with format projects/{{project}}/regions/{{region}}/routers/{{name}} |
| name | Name of the resource. |
| self\_link | The URI of the created resource. |

