variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "vpc_name" {
  type = string
}

variable "subnets" {
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}