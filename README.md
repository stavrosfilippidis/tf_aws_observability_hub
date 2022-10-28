# tf_aws_observability_hub
This module spawns a Monitoring Dashbpard built on top of Grafana that can be populated with different input sources. 


output "observability_platform_security_group_id" {
  value       = aws_security_group.observability_platform_security_group.id
  description = "Security Group ID used for the obs hub."
}

output "observability_platform_dns_record" {
  value       = "https://${aws_route53_record.observability_platform.name}.${data.aws_route53_zone.hosted_zone.name}:${var.observability_platform_reverse_proxy_port}"
  description = "Observability Platform DNS recod"
}

