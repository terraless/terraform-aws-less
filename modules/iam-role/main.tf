locals {
  trusted_aws_identifiers = distinct(concat(var.trusted_aws_identifiers, [module.arns.iam_root_arn]))
}

module "arns" {
  source = "../arns"
}

resource "aws_iam_role" "role" {
  count = var.role_name == "" ? 0 : 1

  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = local.trusted_aws_identifiers
    }
  }
}

data "aws_iam_policy_document" "service_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = var.trusted_identity_providers
    }
  }
}

resource "aws_iam_role" "service" {
  count = var.service_role == "" ? 0 : 1

  name               = var.service_role
  assume_role_policy = data.aws_iam_policy_document.service_assume_role.json
}

output "role" {
  description = "IAM role name"
  value       = var.role_name == "" ? "" : aws_iam_role.role[0].name
}

output "service" {
  description = "IAM role for service"
  value       = var.service_role == "" ? "" : aws_iam_role.service[0].name
}
