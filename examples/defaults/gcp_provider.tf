variable "gcp_region" {
  default = "us-east1"
}

variable "gcp_project" {}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}
