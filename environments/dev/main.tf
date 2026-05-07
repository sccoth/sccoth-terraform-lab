provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  project            = var.project_id
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_subnetwork" "subnets" {
  for_each = var.subnets

  name                     = each.value.name
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = each.value.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = each.value.pods_range_name
    ip_cidr_range = each.value.pods_ip_cidr_range
  }

  secondary_ip_range {
    range_name    = each.value.svc_range_name
    ip_cidr_range = each.value.svc_ip_cidr_range
  }

  depends_on = [
    google_project_service.compute
  ]
}