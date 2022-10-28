data "aws_route53_zone" "hosted_zone" {
  name         = var.hosted_zone
  private_zone = true
}

resource "aws_route53_record" "observability_hub" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.dns_record_name
  type    = "A"

  alias {
    name                   = aws_lb.observability_hub.dns_name
    zone_id                = aws_lb.observability_hub.zone_id
    evaluate_target_health = true
  }
}


