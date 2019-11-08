data "aws_iam_group" "this" {
  count      = length(var.iam_groups)
  group_name = var.iam_groups[count.index]
}

data "aws_iam_role" "this" {
  count = length(var.iam_roles)
  name  = var.iam_roles[count.index]
}

data "aws_iam_user" "this" {
  count     = length(var.iam_users)
  user_name = var.iam_users[count.index]
}

data "aws_route53_zone" "this" {
  count = length(var.route53_zones)
  name  = var.route53_zones[count.index]
}

