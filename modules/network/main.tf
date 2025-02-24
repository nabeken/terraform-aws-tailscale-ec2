resource "aws_network_interface" "tailscale" {
  subnet_id = var.vpc_subnet_id

  security_groups = var.security_group_ids

  enable_primary_ipv6 = var.enable_ipv6 ? true : false
  ipv6_address_count  = var.enable_ipv6 ? 1 : 0

}

resource "aws_eip" "tailscale" {
  domain            = "vpc"
  network_interface = aws_network_interface.tailscale.id
}
