resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_name
  subnetwork = var.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  deletion_protection = false
}

resource "google_container_node_pool" "primary" {
  name     = var.node_pool_name
  location = var.location
  project  = var.project_id
  cluster  = google_container_cluster.cluster.name

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
