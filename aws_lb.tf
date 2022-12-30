
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_autoscaling_group" "observability_hub" {
    name = aws_autoscaling_group.observability_hub.name
}

data "aws_subnet_ids" "subnet" {
  vpc_id = data.aws_vpc.vpc.id
  
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

resource "aws_lb" "observability_hub" {
  name                             =  "observability-hub-${random_string.uid.result}"
  load_balancer_type               =  "network"
  subnets                          =  tolist(data.aws_subnet_ids.subnet.ids) 
  internal                         =  true 
  enable_cross_zone_load_balancing =  true 

  tags = {
      Name                = "Network Load Balancer for ${var.module_name} module."
      TerraformWorkspace  = terraform.workspace
      TerraformModule     = basename(abspath(path.module))
      TerraformRootModule = basename(abspath(path.root))
  }

  lifecycle {
    create_before_destroy = true
  }  
}

resource "aws_lb_listener" "observability_hub" {  
  load_balancer_arn  =  aws_lb.observability_hub.arn 
  port               =  var.obs_hub_port
  protocol           = "TCP" 
 
  default_action {    
    target_group_arn = aws_lb_target_group.observability_hub.arn
    type             = "forward"  
  }
}

resource "aws_lb_target_group" "observability_hub" {  
  name       = "observability-hub-${random_string.uid.result}"
  port       = var.obs_hub_port
  protocol   = "TCP"   
  vpc_id     = var.vpc_id
  
  tags = {
      Name                = "NLB Target Group for the observability hub."
      TerraformWorkspace  = terraform.workspace
      TerraformModule     = basename(abspath(path.module))
      TerraformRootModule = basename(abspath(path.root))
  }
  
  health_check {
     protocol = "TCP"
     port     = var.obs_hub_port
     interval = 15
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "observability_hub" {
  alb_target_group_arn   = aws_lb_target_group.observability_hub.arn
  autoscaling_group_name = aws_autoscaling_group.observability_hub.id
}


