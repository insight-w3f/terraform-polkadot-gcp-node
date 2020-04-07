variable "vpc_name" {}
variable "public_key_path" {}
variable "private_key_path" {}

module "network" {
  source   = "github.com/insight-w3f/terraform-polkadot-gcp-network.git?ref=master"
  vpc_name = var.vpc_name
  project  = var.gcp_project
  region   = var.gcp_region
}


module "defaults" {
  source            = "../.."
  private_subnet_id = module.network.public_subnets[0]
  public_subnet_id  = module.network.private_subnets[0]
  security_group_id = module.network.sentry_security_group_id[0]
  public_key_path   = var.public_key_path
  private_key_path  = var.private_key_path

  create           = true
  create_eip       = true
  root_volume_size = "50"
  node_name        = "test"
}
