data "aws_ami" "fedora_coreos" {
  most_recent = true
  owners      = ["125523088429"] // Fedora Core OS 

  # aws ec2 describe-images --owners 125523088429 --region us-east-1  

  filter {
    name   = "name"
    values = [var.ami_id]
  }
}