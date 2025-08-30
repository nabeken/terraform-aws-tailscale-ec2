output "iam_role_arn" {
  description = "IAM role of EC2 Instance Profile"
  value       = aws_iam_role.instance.arn
}

output "instance_profile_arn" {
  description = "ARN of EC2 Instance Profile"
  value       = aws_iam_instance_profile.instance_profile.arn
}

output "instance_profile_name" {
  description = "Name of EC2 Instance Profile"
  value       = aws_iam_instance_profile.instance_profile.name
}
