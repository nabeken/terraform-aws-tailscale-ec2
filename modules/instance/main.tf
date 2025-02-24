data "aws_ami" "ubuntu_linux_2404" {
  most_recent = true
  owners      = ["099720109477"] # refer to the official AMIs by Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_id" "tailscale" {
  byte_length = 8
}

resource "aws_instance" "tailscale" {
  ami                  = data.aws_ami.ubuntu_linux_2404.id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile_name

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    http_protocol_ipv6     = "enabled"
    instance_metadata_tags = "enabled"
  }

  user_data = file("${path.module}/user_data.sh.tpl")

  tags = {
    Name = "${var.resource_prefix}-${random_id.tailscale.hex}"
  }
}
