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

  ip                     = google_compute_address.this[0].address
  user                   = "ubuntu"
  private_key_path       = var.private_key_path
  playbook_file_path     = "${path.module}/ansible/main.yml"
  requirements_file_path = "${path.module}/ansible/requirements.yml"
  forks                  = 1

  playbook_vars = {
    node_exporter_user            = var.node_exporter_user,
    node_exporter_password        = var.node_exporter_password,
    project                       = var.project,
    polkadot_binary_url           = "https://github.com/w3f/polkadot/releases/download/v0.7.21/polkadot",
    polkadot_binary_checksum      = "sha256:af561dc3447e8e6723413cbeed0e5b1f0f38cffaa408696a57541897bf97a34d",
    node_exporter_binary_url      = "https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz",
    node_exporter_binary_checksum = "sha256:b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424",
    polkadot_restart_enabled      = true,
    polkadot_restart_minute       = "50",
    polkadot_restart_hour         = "10",
    polkadot_restart_day          = "1",
    polkadot_restart_month        = "*",
    polkadot_restart_weekday      = "*",
    telemetry_url                 = var.telemetry_url,
    logging_filter                = var.logging_filter,
    relay_ip_address              = var.relay_node_ip,
    relay_p2p_address             = var.relay_node_p2p_address
  }

  module_depends_on = google_compute_instance.this
}