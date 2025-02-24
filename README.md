# terraform-aws-tailscale-ec2

[![Pre-Commit](https://github.com/nabeken/terraform-aws-tailscale-ec2/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/nabeken/terraform-aws-tailscale-ec2/actions/workflows/pre-commit.yml)

`terraform-aws-tailscale-ec2` is a Terraform module that provisions necessary resources for Talscale on EC2.
- Security Groups to allow Tailscale's WireGuard traffic
- ENI associated with EIP and IPv6
- EC2 instance to install Tailscale and tweak the configuration

As of Feb 24 2025, the module do not use Tailscale's Auth Key to join an instance automatically to your tailnet. An admin needs to login to an instance via AWS Sessions Manager to execute `tailscale up` command.

## Modules

The top modules refer to three submodules in order to provision all necessary resources at once. If you want to have EIP and IPv6 address portability across EC2 instance recreation, it would be better to use the submodule and compose a main module by yourself.

## Example

Using the main module:
```terraform
module "tailscale_ec2" {
  source = "nabeken/tailscale-ec2/aws"

  instance_type             = "t4g.micro"
  vpc_subnet_id             = module.vpc.public_subnets[0]
  vpc_id                    = module.vpc.vpc_id
  iam_instance_profile_name = module.iam_instance_profile.instance_profile_name
  enable_ipv6               = true
}
```

Using the submodules:
```terraform
module "tailscale_ec2_security_group" {
  source = "nabeken/tailscale-ec2/aws//modules/security_group"

  resource_prefix = "tailscale-exit-node"
  vpc_id          = module.vpc.vpc_id
}

module "tailscale_ec2_network" {
  source = "nabeken/tailscale-ec2/aws//modules/network"

  vpc_subnet_id      = module.vpc.public_subnets[0]
  security_group_ids = [module.tailscale_ec2_security_group.security_group_id]

  enable_ipv6 = true
}

module "tailscale_ec2_instance" {
  source = "nabeken/tailscale-ec2/aws//modules/instance"


  resource_prefix           = "tailscale-exit-node"
  instance_type             = "t4g.micro"
  iam_instance_profile_name = module.iam_instance_profile.instance_profile_name
  network_interface_id      = module.tailscale_ec2_network.network_interface_id
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.79 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/network/security-group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_group_ids"></a> [additional\_security\_group\_ids](#input\_additional\_security\_group\_ids) | Additional IDs of security group for the instance | `list(string)` | `[]` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Enable IPv6 | `bool` | n/a | yes |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | Instance profile name | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance Type | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | A prefix for the resources | `string` | `"tailscale"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | A VPC ID where EC2 instance belongs to | `string` | n/a | yes |
| <a name="input_vpc_subnet_id"></a> [vpc\_subnet\_id](#input\_vpc\_subnet\_id) | A VPC Subnet ID where EC2 instance belongs to | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
