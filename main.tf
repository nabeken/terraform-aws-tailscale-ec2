module "security_group" {
  source = "./modules/security-group"

  vpc_id = var.vpc_id
}

module "network" {
  source = "./modules/network"

  vpc_subnet_id      = var.vpc_subnet_id
  security_group_ids = concat([module.security_group.security_group_id], var.additional_security_group_ids)
  enable_ipv6        = var.enable_ipv6
}

module "instance" {
  source = "./modules/instance"

  resource_prefix           = var.resource_prefix
  instance_type             = var.instance_type
  iam_instance_profile_name = var.iam_instance_profile_name
  network_interface_id      = module.network.network_interface_id
}
