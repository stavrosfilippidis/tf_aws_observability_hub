resource "aws_security_group" "observability_hub_security_group" {
  name     = "${var.module_name}_${random_string.uid.result}"

  description = "Allow all the necessary traffic to and from the Observability Platform."
  vpc_id      = var.vpc_id
  
  tags = {
    Name                = "Observability Hub Server security group."
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
}

resource "aws_security_group_rule" "obs_hub_ingress" {
  type                     = "ingress"
  description              = "Egress port used when connecting the observability hub with the obs hubs cluster."
  from_port                = var.obs_hub_port
  to_port                  = var.obs_hub_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.vpc.cidr_block]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}

resource "aws_security_group_rule" "obs_hub_ssh_access" {
  type                     = "ingress"
  description              = "Igress port used when connecting the observability hub with the obs hub cluster."
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}

