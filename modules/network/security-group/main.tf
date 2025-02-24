resource "aws_security_group" "tailscale" {
  description = "Allow Tailscale traffic"
  vpc_id      = var.vpc_id
}

// Allow ICMP traffic
resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv4_icmp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}
resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv6_icmpv6" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "icmpv6"
  from_port         = -1
  to_port           = -1
}
resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ipv4_icmp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}
resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ipv6_icmpv6" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "icmpv6"
  from_port         = -1
  to_port           = -1
}

// Allow egress UDP/TCP traffic
resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv4_udp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "udp"
  from_port         = 0
  to_port           = 65535
}
resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv6_udp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "udp"
  from_port         = 0
  to_port           = 65535
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv4_tcp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
}
resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv6_tcp" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
}

// Allow ingress Wireguard traffic
resource "aws_vpc_security_group_ingress_rule" "allow_wireguard_ipv4" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "udp"
  from_port         = 41641
  to_port           = 41641
}
resource "aws_vpc_security_group_ingress_rule" "allow_wireguard_ipv6" {
  security_group_id = aws_security_group.tailscale.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "udp"
  from_port         = 41641
  to_port           = 41641
}
