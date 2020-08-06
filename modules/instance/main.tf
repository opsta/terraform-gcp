# ---------------------------------------------------------------------------------------------------------------------
# CREATE GCP COMPUTE INSTANCE(S)
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "instance" {
  name                      = var.instance_name
  machine_type              = var.gcp_instance_type
  zone                      = var.gcp_zone
  tags                      = var.gcp_instance_tags
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
      size  = var.gcp_instance_boot_disk_size
      type  = var.gcp_instance_boot_disk_type
    }
  }

  network_interface {
    network    = var.gcp_instance_network
    subnetwork = var.gcp_instance_subnetwork

    dynamic "access_config" {
      for_each = var.public_ip_acess == false ? [] : [{ "x" : "y" }]
      content {

      }
    }
  }

  scheduling {
    preemptible       = var.gcp_preemptible
    automatic_restart = ! var.gcp_preemptible
  }

  metadata = {
    ssh-keys                   = var.ssh_username == "" || var.ssh_public_key == "" ? null : "${var.ssh_username}:${var.ssh_public_key}"
    windows-startup-script-ps1 = var.rdp_username == "" || var.rdp_password == "" ? null : data.template_file.init.rendered
  }
}

data "template_file" "init" {
  template = file("${path.module}/templates/user_data.ps1")

  vars = {
    instance_user     = var.rdp_username
    instance_password = var.rdp_password
    instance_name     = var.instance_name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ANSIBLE INVENTORY
# This will automatically create Ansible Inventory in ./inventories/*.ini directory to use with Ansible to orchetrate
# build the system
# ---------------------------------------------------------------------------------------------------------------------

data "template_file" "ansible_inventory" {
  count = var.generate_ansible_inventory ? 1 : 0

  template = "${file("${path.module}/templates/ansible_inventory.ini")}"
  vars = {
    instance_group = var.instance_name
    instance_host  = "${var.instance_name}-server ansible_user=${var.ssh_username} ansible_host=${google_compute_instance.instance.network_interface.0.access_config.0.nat_ip} ansible_port=${var.ssh_port}"
  }
}

resource "local_file" "ansible_inventory_file" {
  count = var.generate_ansible_inventory ? 1 : 0

  content  = data.template_file.ansible_inventory[0].rendered
  filename = "${var.ansible_inventory_path}/${var.instance_name}.ini"
}
