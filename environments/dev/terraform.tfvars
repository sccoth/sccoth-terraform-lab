project_id = "sccoth-dev"
region     = "europe-west1"
vpc_name   = "lab-vpc-dev"

subnets = {
  gke = {
    name                = "gke-subnet-dev"
    ip_cidr_range       = "10.10.0.0/20"
    region              = "europe-west1"
    pods_range_name     = "pods"
    pods_ip_cidr_range  = "10.20.0.0/16"
    svc_range_name      = "services"
    svc_ip_cidr_range   = "10.30.0.0/20"
  }
}