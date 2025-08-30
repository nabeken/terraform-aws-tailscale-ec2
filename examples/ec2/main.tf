module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  cidr = "10.15.0.0/16"

  azs = [
    "ap-northeast-1a", # apne1-az4
    "ap-northeast-1c", # apne1-az1
    "ap-northeast-1d", # apne1-az2
  ]

  public_subnets = [
    "10.15.10.0/24",
    "10.15.11.0/24",
    "10.15.12.0/24",
  ]

  private_subnets = [
    "10.15.13.0/24",
    "10.15.14.0/24",
    "10.15.15.0/24",
  ]

  enable_ipv6                                   = true
  public_subnet_assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes  = [0, 1, 2]
  private_subnet_ipv6_prefixes = [3, 4, 5]
}

module "iam_instance_profile" {
  source = "./ec2_instance_profile"
}

module "tailscale_ec2" {
  source = "../../"

  instance_type             = "t4g.nano"
  vpc_subnet_id             = module.vpc.public_subnets[0]
  vpc_id                    = module.vpc.vpc_id
  iam_instance_profile_name = module.iam_instance_profile.instance_profile_name
  enable_ipv6               = true
}
