resource "aws_security_group" "observability_hub_security_group" {
  name     = "${var.module_name}_${random_string.uid.result}"

  description = "Allow all the necessary traffic to and from the Observability Platform."
  vpc_id      = data.aws_vpc.vpc.id
  
  tags = {
    Name                = "Observability Hub Server security group."
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
}

resource "aws_security_group_rule" "prometheus_metrics_egress" {
  type                     = "egress"
  description              = "Egress port used when connecting the observability hub with the metrics aggregator cluster."
  from_port                = var.prometheus_input_source_port
  to_port                  = var.prometheus_input_source_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.vpc.cidr_block]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}

