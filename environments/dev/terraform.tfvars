project_id = "sccoth-dev"
region     = "us-central1"
vpc_name   = "vpc-dev"

subnets = {
  dev_main = {
    name          = "dev-subnet"
    ip_cidr_range = "10.10.0.0/16"
    region        = "us-central1"
  }
  dev_apps = {
  name          = "dev-apps-subnet"
  ip_cidr_range = "10.11.0.0/16"
  region        = "us-central1"
}
  dev_apps = {
  name          = "dev-db-subnet"
  ip_cidr_range = "10.12.0.0/16"
  region        = "us-central1"
}
}