# Cloud SQL module

Module for provision Cloud SQL on Google Cloud

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| google | >= 3.32.0 |
| random | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.32.0 |
| random | >= 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activation\_policy | This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON\_DEMAND. | `string` | `"ALWAYS"` | no |
| auto\_size | Configuration to increase storage size automatically. Note that future terraform apply calls will attempt to resize the disk to the value specified in disk\_size - if this is set, do not set disk\_size. | `bool` | `true` | no |
| availability\_type | The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).' | `string` | `"ZONAL"` | no |
| backup\_start\_time | If set this variable will enable backup automatically. HH:MM format time indicating when backup configuration starts. | `string` | `null` | no |
| database\_flags | A set of key/value user label pairs to assign to the instance. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| database\_type | Database type to install. (mysql, postgres, sqlserver) | `string` | `"mysql"` | no |
| database\_version | Version database to setup (see also https://cloud.google.com/sql/docs/sqlserver/db-versions) | `string` | `"5.7"` | no |
| databases | List of map(string) (name ,charset, collation) to create databases (empty will not created) | `list(map(string))` | `[]` | no |
| disk\_size | The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased. | `number` | `10` | no |
| disk\_type | The type of data disk: PD\_SSD or PD\_HDD. | `string` | `"PD_SSD"` | no |
| ip\_configuration | A object to configuration ip policy. document on this (https://www.terraform.io/docs/providers/google/r/sql_database_instance.html) | <pre>object({<br>    ipv4_enabled    = bool<br>    private_network = string<br>    require_ssl     = string<br>    authorized_networks = list(object({<br>      expiration_time = string<br>      name            = string<br>      value           = string<br>    }))<br>  })</pre> | `null` | no |
| is\_private | Enable this option to true, To give private ip for instace. | `bool` | `false` | no |
| labels | A set of key/value user label pairs to assign to the instance. | `map(string)` | `null` | no |
| location\_preference | Document on this https://www.terraform.io/docs/providers/google/r/sql_database_instance.html | <pre>object({<br>    follow_gae_application = string<br>    zone                   = string<br>  })</pre> | `null` | no |
| machine\_type | Type of instance to provision database | `string` | `"db-f1-micro"` | no |
| maintenance\_window | instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates. The maintenance window is specified in UTC time. | <pre>object({<br>    day       = number<br>    hour      = number<br>    is_stable = bool<br>  })</pre> | `null` | no |
| master\_instance\_name | The name of the instance that will act as the master in the replication setup. Note, this requires the master to have binary\_log\_enabled set, as well as existing backups. | `string` | `null` | no |
| name | The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week. | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| region | The region the instance will sit in. Note, Cloud SQL is not available in all regions - choose from one of the options listed here. A valid region must be provided to use this resource. If a region is not provided in the resource definition, the provider region will be used instead, but this will be an apply-time error for instances if the provider region is not supported with Cloud SQL. If you choose not to provide the region argument for this resource, make sure you understand this. | `string` | `null` | no |
| replica\_configuration | instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates. The maintenance window is specified in UTC time. | <pre>object({<br>    ca_certificate            = string<br>    client_certificate        = string<br>    client_key                = string<br>    connect_retry_interval    = number<br>    dump_file_path            = string<br>    failover_target           = bool<br>    master_heartbeat_period   = number<br>    username                  = string<br>    password                  = string<br>    ssl_cipher                = string<br>    verify_server_certificate = bool<br>  })</pre> | `null` | no |
| root\_password | Initial root password. Required for MS SQL Server, ignored by MySQL and PostgreSQL. | `string` | `"5.7"` | no |
| ssl\_common\_name | The common name to be used in the certificate to identify the client | `string` | n/a | yes |
| users | List of map(string) (host ,name, password) to create user for connect database (empty will not created) | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cert | The actual certificate data for this client certificate |
| cert\_serial\_number | The serial number extracted from the certificate data |
| connection\_name | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| create\_time | The time when the certificate was created in RFC 3339 format, for example 2012-11-15T16:19:00.094Z |
| databases\_id | an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}} |
| databases\_name | All databases information is has status created |
| databases\_self\_link | The URI of the created resource. |
| expiration\_time | The time when the certificate expires in RFC 3339 format, for example 2012-11-15T16:19:00.094Z |
| first\_ip\_address | The first IPv4 address of any type assigned. This is to support accessing the first address in the list in a terraform output when the resource is configured with a count. |
| ip\_address\_ip\_address | The IPv4 address assigned. |
| ip\_address\_time\_to\_retire | The time this IP address will be retired, in RFC 3339 format. |
| ip\_address\_type | The type of this IP address. |
| private\_ip\_address | The first private (PRIVATE) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| private\_key | The private key associated with the client certificate |
| public\_ip\_address | The first public (PRIMARY) IPv4 address assigned. This is a workaround for an issue fixed in Terraform 0.12 but also provides a convenient way to access an IP of a specific type without performing filtering in a Terraform config. |
| self\_link | The URI of the created resource. |
| server\_ca\_cert | The CA cert of the server this client cert was generated from |
| server\_ca\_cert\_cert | The CA Certificate used to connect to the SQL Instance via SSL. |
| server\_ca\_cert\_common\_name | The CN valid for the CA Cert. |
| server\_ca\_cert\_create\_time | Creation time of the CA Cert. |
| server\_ca\_cert\_expiration\_time | Expiration time of the CA Cert. |
| server\_ca\_cert\_sha1\_fingerprint | SHA Fingerprint of the CA Cert. |
| service\_account\_email\_address | The service account email address assigned to the instance. |
| settings\_version | Used to make sure changes to the settings block are atomic. |
| sha1\_fingerprint | The SHA1 Fingerprint of the certificate |
| users | all users created for use to connect database |

