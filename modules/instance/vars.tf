variable "resource_prefix" {
  description = "A prefix for the resources"

  type    = string
  default = "tailscale"
}

variable "instance_type" {
  description = "EC2 Instance Type"

  type = string
}

variable "iam_instance_profile_name" {
  description = "Instance profile name"

  type = string
}

variable "network_interface_id" {
  description = "A network interface ID to attach to the intance"

  type = string
}
