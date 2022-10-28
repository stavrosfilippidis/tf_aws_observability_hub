resource "aws_security_group" "observability_hub_security_group" {
  name     = "${var.module_name}_${random_string.uid.result}"

  description = "Allow all the necessary traffic to and from the Observability Platform."
  vpc_id      = data.aws_vpc.vpc.id
  
  tags = {
    Name                = "Observability Hub Server"
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
}

resource "aws_security_group_rule" "prometheus_metrics_egress" {
  type                     = "egress"
  description              = "Prometheus metrics port used when configuring the source for the Dashboard."
  from_port                = var.prometheus_input_source_port
  to_port                  = var.prometheus_input_source_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.vpc.cidr_block]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}

resource "aws_security_group_rule" "fluentd_logs_egress_tcp" {
  type                     = "ingress"
  description              = "Used for sending out logs to the fluentd aggregator over tcp."
  from_port                = var.obs_hub_port
  to_port                  = var.obs_hub_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.vpc.cidr_block]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}


