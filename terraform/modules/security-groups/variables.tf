variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "admin_cidr_blocks" {
  type = list(string)
}

variable "app_ingress_cidr_blocks" {
  type = list(string)
}
