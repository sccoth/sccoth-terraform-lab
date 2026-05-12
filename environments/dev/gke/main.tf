provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source = "../../../modules/gke"

  project_id          = var.project_id
  location            = var.zone
  cluster_name        = var.cluster_name
  network_name        = var.network_name
  subnet_name         = var.subnet_name
  pods_range_name     = var.pods_range_name
  services_range_name = var.services_range_name

  node_pool_name = var.node_pool_name
  node_count     = var.node_count
  machine_type   = var.machine_type
  disk_type      = var.disk_type
  disk_size_gb   = var.disk_size_gb
  
  # test gke stack detection
  # trigger gke deployment
}
