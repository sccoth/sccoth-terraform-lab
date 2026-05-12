provider "google" {
  project = var.project_id
  region  = var.region
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = "sccoth-terraform-state-dev"
    prefix = "dev/network"
  }
}

module "gke" {
  source = "../../../modules/gke"

  project_id   = var.project_id
  location     = var.zone
  cluster_name = var.cluster_name

  network_name        = data.terraform_remote_state.network.outputs.vpc_name
  subnet_name         = data.terraform_remote_state.network.outputs.subnet_name
  pods_range_name     = data.terraform_remote_state.network.outputs.pods_range_name
  services_range_name = data.terraform_remote_state.network.outputs.services_range_name

  node_pool_name = var.node_pool_name
  node_count     = var.node_count
  machine_type   = var.machine_type
  disk_type      = var.disk_type
  disk_size_gb   = var.disk_size_gb
  
  # test gke stack detection
  # trigger gke deployment
}
