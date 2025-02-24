output "network_interface_id" {
  description = "ENI ID"
  value       = aws_network_interface.tailscale.id
}
