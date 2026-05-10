output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnets" {
  value = {
    for k, subnet in google_compute_subnetwork.subnets :
    k => {
      name   = subnet.name
      region = subnet.region
      cidr   = subnet.ip_cidr_range
    }
  }
}