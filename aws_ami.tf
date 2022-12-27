data "aws_ami" "fedora_coreos" {
  most_recent = true
  owners      = ["125523088429"] // Fedora Core OS 
  filter {
    name   = "name"
    values = [var.ami_id]
  }
}