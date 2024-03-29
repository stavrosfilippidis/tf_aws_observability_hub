module "observability_platform_cluster" {
  source = "../../"

  vpc_id                            = data.aws_vpc.default.id
  subnet_ids                        = tolist(data.aws_subnet_ids.default.ids)
  authorized_key                    = var.authorized_key
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
