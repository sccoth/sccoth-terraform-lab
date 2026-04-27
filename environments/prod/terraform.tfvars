project_id = "sccoth-prod"
region     = "us-central1"
vpc_name   = "vpc-prod"

subnets = {
  prod_main = {
    name          = "prod-subnet"
    ip_cidr_range = "10.20.0.0/16"
    region        = "us-central1"
  }
}