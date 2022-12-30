module "observability_platform_cluster" {
  source = "../../"

  vpc_id                            = data.aws_vpc.default.id
  subnet_ids                        = tolist(data.aws_subnet_ids.default.ids)
  ssh_authorized_keys               = var.ssh_authorized_keys
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "default-for-az"
    values = [true]
  }
}