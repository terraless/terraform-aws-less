module "arns" {
  source = "../../arns"

  route53_zones = var.zones
}

data "aws_iam_policy_document" "full_access" {
  statement {
    sid = "Route53ZoneFullAccess"

    actions = [
      "route53:*",
    ]

    resources = module.arns.route53_zone_arns
  }

  statement {
    sid = "Route53List"

    actions = [
      "route53:ListHostedZonesByName",
      "route53:ListHostedZones",
    ]

    resources = ["*"]
  }

  statement {
    sid = "Route53GetChange"

    actions = [
      "route53:GetChange",
    ]

    resources = [module.arns.route53_all_change_arn]
  }
}
