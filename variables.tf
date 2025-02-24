variable "resource_prefix" {
  description = "A prefix for the resources"

  type    = string
  default = "tailscale"
}

variable "vpc_id" {
  description = "A VPC ID where EC2 instance belongs to"

  type = string
}

variable "vpc_subnet_id" {
  description = "A VPC Subnet ID where EC2 instance belongs to"

  type = string
}

variable "instance_type" {
  description = "EC2 Instance Type"

  type = string
}

variable "additional_security_group_ids" {
  description = "Additional IDs of security group for the instance"

  type    = list(string)
  default = []
}

variable "iam_instance_profile_name" {
  description = "Instance profile name"

  type = string
}

variable "enable_ipv6" {
  description = "Enable IPv6"

  type = bool
}
