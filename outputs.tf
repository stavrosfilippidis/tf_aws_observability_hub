output "observability_platform_security_group_id" {
  value       = aws_security_group.observability_hub_security_group.id
  description = "Security ID used for the security groups in other modules."
}

