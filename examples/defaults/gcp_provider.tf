variable "gcp_region" {
  default = "us-east1"
}

provider "google" {
  region = var.gcp_region
}
