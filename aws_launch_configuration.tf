data "aws_availability_zones" "observability_hub" {
  state = "available"
}

resource "aws_launch_template" "observability_hub" {
  name                   =  "${var.module_name}_${random_string.uid.result}"
  image_id               =  data.aws_ami.fedora_coreos.id
  instance_type          =  var.instance_type
  vpc_security_group_ids =  [aws_security_group.observability_hub_security_group.id]
  user_data              =  base64encode(data.ct_config.observability_hub_cluster.rendered)
  
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.instance_volume_size
    }
  }
  
  iam_instance_profile  {
    name = aws_iam_instance_profile.observability_hub.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
        Name                = "${var.module_name}"
        TerraformWorkspace  = terraform.workspace
        TerraformModule     = basename(abspath(path.module))
        TerraformRootModule = basename(abspath(path.root))
    }
  }

  tags = {
        Name                = "${var.module_name}"
        TerraformWorkspace  = terraform.workspace
        TerraformModule     = basename(abspath(path.module))
        TerraformRootModule = basename(abspath(path.root))
    }
}

resource "aws_autoscaling_group" "observability_hub" {
  name                    = "${var.module_name}_${random_string.uid.result}"
  vpc_zone_identifier     = var.subnet_ids

  desired_capacity        = var.instance_desired_count
  max_size                = var.instance_max_count
  min_size                = var.instance_min_count

  launch_template {
    id      = aws_launch_template.observability_hub.id
    version = aws_launch_template.observability_hub.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 90
    }
    triggers = ["tag"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "${var.module_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "TerraformWorkspace"
    value               = terraform.workspace
    propagate_at_launch = true
  }

  tag {
    key                 = "TerraformModule"
    value               = basename(abspath(path.module))
    propagate_at_launch = true
  }
}

