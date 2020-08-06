# Cloud Memory Store module (Only Redis for now)

Module for provision Cloud MemoryStore on Google Cloud

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
| alternative\_location\_id | Only applicable to STANDARD\_HA tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in [locationId]. | `string` | `null` | no |
| authorized\_network | The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used. | `string` | `null` | no |
| database\_type | Type of database to use in memory store service. Must be one of these values: redis, memcached. | `string` | `"redis"` | no |
| database\_version | Version of database to use in memory store service. Should relate on database\_type | `string` | `"4.0"` | no |
| display\_name | An arbitrary and optional user-provided name for the instance. | `string` | `null` | no |
| enable\_ha | Ture if you want to enable highly available primary/replica instances | `bool` | `false` | no |
| is\_private | The connection mode of the Redis instance. | `bool` | `true` | no |
| labels | Resource labels to represent user provided metadata. | `map(string)` | `null` | no |
| location\_id | The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For STANDARD\_HA tier, instances will be created across two zones for protection against zonal failures. If [alternativeLocationId] is also provided, it must be different from [locationId]. | `string` | `null` | no |
| memory\_size\_gb | Redis memory size in GiB. | `number` | `1` | no |
| name | The ID of the instance or a fully qualified identifier for the instance. | `string` | n/a | yes |
| project | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| redis\_configs | Redis configuration parameters, according to http://redis.io/topics/config. Please check Memorystore documentation for the list of supported parameters: https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs | `map(string)` | `null` | no |
| region | The name of the Redis region of the instance. | `string` | `null` | no |
| reserved\_ip\_range | The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused /29 block, for example, 10.0.0.0/29 or 192.168.0.0/29. Ranges must be unique and non-overlapping with existing subnets in an authorized network. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| create\_time | The time the instance was created in RFC3339 UTC format, accurate to nanoseconds. |
| current\_location\_id | The current zone where the Redis endpoint is placed. For Basic Tier instances, this will always be the same as the [locationId] provided by the user at creation time. For Standard Tier instances, this can be either [locationId] or [alternativeLocationId] and can change after a failover event. |
| host | Hostname or IP address of the exposed Redis endpoint used by clients to connect to the service. |
| id | an identifier for the resource with format projects/{{project}}/locations/{{region}}/instances/{{name}} |
| port | The port number of the exposed Redis endpoint. |

