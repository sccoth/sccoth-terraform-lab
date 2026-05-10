variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "vpc_name" {
  type = string
}

variable "subnets" {
  type = map(object({
    name                = string
    ip_cidr_range       = string
    region              = string
    pods_range_name     = string
    pods_ip_cidr_range  = string
    svc_range_name      = string
    svc_ip_cidr_range   = string
  }))
}