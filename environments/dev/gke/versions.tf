terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "sccoth-terraform-state-dev"
    prefix = "dev/gke"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}