# resource "aws_security_group_rule" "vpn_prometheus_egress" {
#   type              = "egress"
#   description       = "Used for egress traffic from the vpn to the database "
#   from_port         = var.database_port
#   to_port           = var.database_port
#   protocol          = "tcp"
#   cidr_blocks       = [data.aws_vpc.default.cidr_block]
#   security_group_id = var.vpn_security_group_id
# }

resource "aws_security_group_rule" "https_egress" {
  type                     = "egress"
  description              = "Used for connecting to internet resources over https."
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"] 
  security_group_id        = module.observability_platform_cluster.observability_platform_security_group_id
}

resource "aws_security_group_rule" "http_egress" {
  type                     = "egress"
  description              = "Used for connecting to internet resources over http."
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"] 
  security_group_id        = module.observability_platform_cluster.observability_platform_security_group_id
}

resource "aws_security_group_rule" "dns_connectivity" {
  type                     = "egress"
  description              = "Used for resolving hostnames over DNS."
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  cidr_blocks              = [data.aws_vpc.default.cidr_block]  
  security_group_id        = module.observability_platform_cluster.observability_platform_security_group_id
}

resource "aws_security_group_rule" "dns_connectivity_fallback" {
  type                     = "egress"
  description              = "Used for resolving hostnames over DNS."
  from_port                = 53
  to_port                  = 53
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.default.cidr_block] 
  security_group_id        = module.observability_platform_cluster.observability_platform_security_group_id
}
