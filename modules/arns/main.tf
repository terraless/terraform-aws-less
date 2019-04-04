locals {
  partition  = "${coalesce(var.partition, data.aws_partition.current.partition)}"
  region     = "${coalesce(var.region, data.aws_region.current.name)}"
  account_id = "${coalesce(var.account_id, data.aws_caller_identity.current.account_id)}"

  global_format               = "arn:${local.partition}:%s:::%s%s"
  per_account_format          = "arn:${local.partition}:%s::${local.account_id}:%s%s"
  regional_per_account_format = "arn:${local.partition}:%s:${local.region}:${local.account_id}:%s%s"
}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
