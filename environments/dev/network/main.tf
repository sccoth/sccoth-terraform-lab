provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "../../../modules/network"

  project_id          = var.project_id
  region              = var.region
  vpc_name            = var.vpc_name
  subnet_name         = var.subnet_name
  subnet_cidr         = var.subnet_cidr
  pods_range_name     = var.pods_range_name
  pods_cidr           = var.pods_cidr
  services_range_name = var.services_range_name
  services_cidr       = var.services_cidr
}
