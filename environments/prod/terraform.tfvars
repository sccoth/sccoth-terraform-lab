project_id = "sccoth-prod"
region     = "europe-west1"
vpc_name   = "lab-vpc-prod"

subnets = {
  gke = {
    name                = "gke-subnet-prod"
    ip_cidr_range       = "10.40.0.0/20"
    region              = "europe-west1"
    pods_range_name     = "pods"
    pods_ip_cidr_range  = "10.50.0.0/16"
    svc_range_name      = "services"
    svc_ip_cidr_range   = "10.60.0.0/20"
  }
}