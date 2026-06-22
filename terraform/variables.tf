variable "aws_region" {

  description = "AWS Region"
  type        = string
  default     = "ap-south-1"

}

variable "project_name" {

  type    = string
  default = "bmi-health-tracker"

}

variable "environment" {

  type    = string
  default = "dev"

}

variable "vpc_cidr" {

  type    = string
  default = "10.0.0.0/16"

}

variable "admin_cidr_blocks" {

  description = "CIDR blocks allowed to SSH into bastion. Set this to your public IP /32 for real use."
  type        = list(string)
  default     = ["0.0.0.0/0"]

}

variable "app_ingress_cidr_blocks" {

  description = "CIDR blocks allowed to reach the public app load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]

}

variable "instance_type" {

  type    = string
  default = "t3.micro"

}

variable "monitoring_instance_type" {

  type    = string
  default = "t3.small"

}

variable "db_username" {

  type = string

}

variable "db_password" {

  description = "PostgreSQL password. Prefer TF_VAR_db_password or CI secrets instead of committing it in tfvars."
  type        = string
  sensitive   = true

}



variable "key_name" {

  description = "AWS Key Pair"

  type = string

}
