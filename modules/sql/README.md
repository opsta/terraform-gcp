# Cloud SQL module

Module for provision Cloud SQL on Google Cloud

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 0.12   |
| google    | >= 3.21.0 |
| random    | >= 2.2.0  |

## Providers

| Name   | Version   |
| ------ | --------- |
| google | >= 3.21.0 |
| random | >= 2.2.0  |

## Inputs

| Name                | Description                                                                                                                                                                                                                                                                                                                                                                                                                | Type                                                                                               | Default         | Required |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | --------------- | :------: |
| activation_policy   | This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND.                                                                                                                                                                                                                                                                                                                               | `string`                                                                                           | `"ALWAYS"`      |    no    |
| authorized_networks | List of authorized_networks is object contain 3 value. The first is expiration_time = The RFC 3339 formatted date time string indicating when this whitelist expires. The second is name = A name for this whitelist entry. and The last one is value = A CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Must be set even if other two attributes are not for the whitelist to become active. | <pre>list(object({<br> expiration_time = string<br> name = string<br> value = string<br> }))</pre> | `[]`            |    no    |
| auto_size           | Configuration to increase storage size automatically. Note that future terraform apply calls will attempt to resize the disk to the value specified in disk_size - if this is set, do not set disk_size.                                                                                                                                                                                                                   | `bool`                                                                                             | `true`          |    no    |
| availability_type   | The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).'                                                                                                                                                                                                                                                                                                                     | `string`                                                                                           | `"ZONAL"`       |    no    |
| backend_enable      | True if backup configuration is enabled.                                                                                                                                                                                                                                                                                                                                                                                   | `bool`                                                                                             | `true`          |    no    |
| backup_start_time   | HH:MM format time indicating when backup configuration starts.                                                                                                                                                                                                                                                                                                                                                             | `string`                                                                                           | `"00:00"`       |    no    |
| database_type       | Database type to install. (mysql, postgres, sqlserver)                                                                                                                                                                                                                                                                                                                                                                     | `string`                                                                                           | `"mysql"`       |    no    |
| database_version    | version of database to install (see also https://cloud.google.com/sql/docs/sqlserver/db-versions)                                                                                                                                                                                                                                                                                                                          | `string`                                                                                           | `"5.7"`         |    no    |
| databases           | List of map(string) (name ,charset, collation) to create databases (empty will not created)                                                                                                                                                                                                                                                                                                                                | `list(map(string))`                                                                                | `[]`            |    no    |
| disk_size           | The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased.                                                                                                                                                                                                                                                                                                                           | `number`                                                                                           | `10`            |    no    |
| disk_type           | The type of data disk: PD_SSD or PD_HDD.                                                                                                                                                                                                                                                                                                                                                                                   | `string`                                                                                           | `"PD_SSD"`      |    no    |
| instance_name       | instance name to create in cloud sql                                                                                                                                                                                                                                                                                                                                                                                       | `string`                                                                                           | n/a             |   yes    |
| ipv4_enabled        | Whether this Cloud SQL instance should be assigned a public IPV4 address. Either ipv4_enabled must be enabled or a private_network must be configured.                                                                                                                                                                                                                                                                     | `bool`                                                                                             | `null`          |    no    |
| labels              | A set of key/value user label pairs to assign to the instance.                                                                                                                                                                                                                                                                                                                                                             | `map(string)`                                                                                      | `null`          |    no    |
| machine_type        | Type of instance to provision database                                                                                                                                                                                                                                                                                                                                                                                     | `string`                                                                                           | `"db-f1-micro"` |    no    |
| private_network     | The VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. Specifying a network enables private IP. Either ipv4_enabled must be enabled or a private_network must be configured. This setting can be updated, but it cannot be removed after it is set.                                                                                      | `string`                                                                                           | `null`          |    no    |
| require_ssl         | True if mysqld should default to REQUIRE X509 for users connecting over IP.                                                                                                                                                                                                                                                                                                                                                | `bool`                                                                                             | `null`          |    no    |
| ssl_common_name     | The common name to be used in the certificate to identify the client                                                                                                                                                                                                                                                                                                                                                       | `string`                                                                                           | n/a             |   yes    |
| users               | List of map(string) (host ,name, password) to create user for connect database (empty will not created)                                                                                                                                                                                                                                                                                                                    | `list(map(string))`                                                                                | `[]`            |    no    |

## Outputs

| Name               | Description                                                                                        |
| ------------------ | -------------------------------------------------------------------------------------------------- |
| cert               | The actual certificate data for this client certificate                                            |
| cert_serial_number | The serial number extracted from the certificate data                                              |
| create_time        | The time when the certificate was created in RFC 3339 format, for example 2012-11-15T16:19:00.094Z |
| databases          | All databases information is has status created                                                    |
| expiration_time    | The time when the certificate expires in RFC 3339 format, for example 2012-11-15T16:19:00.094Z     |
| private_key        | The private key associated with the client certificate                                             |
| server_ca_cert     | The CA cert of the server this client cert was generated from                                      |
| sha1_fingerprint   | The SHA1 Fingerprint of the certificate                                                            |
| users              | all users created for use to connect database                                                      |

## Example

```terraform
provider "google" {
  credentials = jsonencode(var.credentials)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "sql" {
  source           = "github.com/opsta/terraform-gcp//modules/sql?ref=master"
  instance_name    = "test-db"
  database_type    = "mysql"
  database_version = "5.7"
  ssl_common_name  = "pepodev"

  users = [
    {
      host = "some ip or domain"
      name = "test-user"
    }
  ]

  databases = [
    {
      name      = "hello-db"
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
  ]
}

output "users" {
  value       = module.sql.users
  description = "List of all users to connect database"
}
```