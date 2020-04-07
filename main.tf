module "label" {
  source = "github.com/robc-io/terraform-null-label.git?ref=0.16.1"
  tags = {
    NetworkName = var.network_name
    Owner       = var.owner
    Terraform   = true
    VpcType     = "main"
  }

  environment = var.environment
  namespace   = var.namespace
  stage       = var.stage
}

module "user_data" {
  source         = "github.com/insight-w3f/terraform-polkadot-user-data.git?ref=master"
  cloud_provider = "gcp"
  type           = "library"
}

resource "google_compute_address" "this" {
  count = var.create_eip && var.create ? 1 : 0
  name  = "sentry-${count.index}"
}

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-minimal-1804-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "this" {
  count = var.create ? 1 : 0
  labels = {
    environment = module.label.environment,
    namespace   = module.label.namespace,
    stage       = module.label.stage
  }

  machine_type = var.instance_type
  name         = var.node_name
  zone         = var.zone

  metadata_startup_script = module.user_data.user_data
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  service_account {
    email  = var.security_group_id
    scopes = ["cloud-platform"]
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      size  = var.root_volume_size
      type  = "pd-standard"
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    subnetwork = var.public_subnet_id

    access_config {
      nat_ip = google_compute_address.this[0].address
    }
  }

  network_interface {
    subnetwork = var.private_subnet_id
  }
}

module "ansible" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git"

  inventory_template = "${path.module}/ansible_inventory.tpl"

  inventory_template_vars = {
    node-ip   = google_compute_address.this[0].address
    node-name = var.node_name

    wireguard_validator_pubkey = var.wireguard_validator_pubkey
    validator_vpn_peer_addr    = var.validator_vpn_peer_addr
    validator_ip               = var.validator_ip
  }

  playbook_file_path = "${path.module}/ansible/main.yml"

  playbook_vars = {
    node_exporter_enabled = false
  }

  user             = "ubuntu"
  private_key_path = var.private_key_path

  module_depends_on = google_compute_instance.this
}