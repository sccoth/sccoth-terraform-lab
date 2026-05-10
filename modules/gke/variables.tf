variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "pods_range_name" {
  type = string
}

variable "services_range_name" {
  type = string
}

variable "node_pool_name" {
  type    = string
  default = "primary-pool"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "disk_type" {
  type    = string
  default = "pd-standard"
}

variable "disk_size_gb" {
  type    = number
  default = 30
}
