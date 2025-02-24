variable "vpc_subnet_id" {
  description = "A VPC subnet ID where ENI belongs to"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs that are attached to ENI"
  type        = list(string)
}

variable "enable_ipv6" {
  description = "Enable IPv6 on ENI"
  type        = bool
}
