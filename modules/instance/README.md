# Opsta GCP Instance

This folder contains a [Terraform](https://www.terraform.io/) module to create instance(s) with most default value we used in Opsta on [Google Cloud Platform](https://cloud.google.com).

## How do you use this module

This folder defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your
code by adding a `module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "opsta_gcp_instance" {
  source = "github.com/opsta/terraform-gcp//modules/instance?ref=master"
  # ... See variables.tf for the other parameters you must define for the GCP instance module
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the instance module. The double slash (`//`) is intentional and required. Terraform uses it to specify subfolders within a Git repo (see [module sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in this repo. That way, instead of using the latest version of this module from the `master` branch, which will change every time you run Terraform, you're using a fixed version of the repo.

You can find the other parameters in [variables.tf](variables.tf).

Check out the [examples folder](/examples/instance/) for fully-working sample code.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| local | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ansible\_inventory\_path | Path where Ansible Inventory is going to generate | `string` | `"./inventories"` | no |
| gcp\_instance\_boot\_disk\_size | GCP boot disk size | `number` | `60` | no |
| gcp\_instance\_boot\_disk\_type | GCP boot disk type | `string` | `"pd-standard"` | no |
| gcp\_instance\_image | GCP boot disk image | `string` | `"ubuntu-os-cloud/ubuntu-2004-lts"` | no |
| gcp\_instance\_network | GCP instance network | `string` | `"default"` | no |
| gcp\_instance\_subnetwork | GCP instance subnetwork | `string` | `"default"` | no |
| gcp\_instance\_tags | list of GCP instance tags | `list` | `[]` | no |
| gcp\_instance\_type | GCP instance type | `string` | `"n1-standard-2"` | no |
| gcp\_preemptible | GCP instance preemptible | `bool` | `false` | no |
| gcp\_zone | The GCP zone in which all resources will be created | `string` | `"asia-southeast1-a"` | no |
| instance\_name | GCP instance name | `string` | n/a | yes |
| rdp\_password | RDP Administrator password | `string` | `""` | no |
| rdp\_username | RDP Administrator username | `string` | `""` | no |
| ssh\_port | SSH Port | `number` | `22` | no |
| ssh\_public\_key | Public Key that can be used to SSH to the Instances | `string` | `""` | no |
| ssh\_username | SSH Username | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_name | Instance Name |
| private\_ip | Instance Private IP |
| public\_ip | Instance Public IP |
| rdp\_username | Instance RDP Username |
| ssh\_port | Instance SSH Port |
| ssh\_username | Instance SSH Username |

### SSH access

You can associate an SSH Key with Instances in this cluster by specifying the public key on `ssh_public_key` variable

### RDP access

You can associate RDP username and password with Instances by specifying username on `rdp_username` variable and password on `rdp_password`.
