output "network_interface_id" {
  description = "ENI ID"
  value       = aws_network_interface.tailscale.id
}

output "eip_allocation_id" {
  description = "EIP Allocation ID"
  value       = aws_eip.tailscale.allocation_id
}

output "eip_public_ip" {
  description = "EIP Public IP"
  value       = aws_eip.tailscale.public_ip
}
