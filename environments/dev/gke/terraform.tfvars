project_id = "sccoth-dev"
region     = "europe-west1"
zone       = "europe-west1-b"

cluster_name = "gcp-lab-cluster"

network_name = "lab-vpc-dev"
subnet_name  = "gke-subnet-dev"

pods_range_name     = "pods"
services_range_name = "services"

node_pool_name = "primary-pool"
node_count     = 1
machine_type   = "e2-small"
disk_type      = "pd-standard"
disk_size_gb   = 30
