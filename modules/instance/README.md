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

### SSH access

You can associate an SSH Key with Instances in this cluster by specifying the public key on `ssh_public_key` variable

### RDP access

You can associate RDP username and password with Instances by specifying username on `rdp_username` variable and password on `rdp_password`.
