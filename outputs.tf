output "observability_platform_security_group_id" {
  value       = aws_security_group.observability_hub_security_group.id
  description = "Security ID used for the security groups in other modules."
}

# output "observability_platform_dns_record" {
#   value       = "https://${aws_route53_record.observability_platform.name}.${data.aws_route53_zone.hosted_zone.name}:${var.observability_platform_reverse_proxy_port}"
#   description = "Observability Platform DNS record used for accessing the hub."
# }
