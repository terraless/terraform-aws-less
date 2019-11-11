locals {
  key_arns     = module.arns.kms_key_arns
  iam_root_arn = module.arns.iam_root_arn
}

module "arns" {
  source = "../../arns"

  kms_keys = var.keys

  partition  = var.aws_partition
  account_id = var.aws_account_id
  region     = var.aws_region
}

data "aws_iam_policy_document" "full_access" {
  statement {
    sid = "KMSFullAccess"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = local.key_arns
  }
}

data "aws_iam_policy_document" "decrypt_only" {
  statement {
    sid = "KMSDecryptOnly"

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = local.key_arns
  }
}

data "aws_iam_policy_document" "key_default" {
  statement {
    sid = "key-default"

    principals {
      type = "AWS"

      identifiers = [local.iam_root_arn]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "key_full_access" {
  source_json = data.aws_iam_policy_document.key_default.json

  statement {
    sid = "key-full-access"

    principals {
      type = "AWS"

      # Workaround to avoid empty identifiers
      identifiers = concat(var.full_access_aws_identifiers, [local.iam_root_arn])
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = local.key_arns
  }
}

data "aws_iam_policy_document" "key_decrypt_only" {
  source_json = data.aws_iam_policy_document.key_default.json

  statement {
    sid = "key-decrypt-only"

    principals {
      type = "AWS"

      # Workaround to avoid empty identifiers
      identifiers = concat(var.decrypt_only_aws_identifiers, [local.iam_root_arn])
    }

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = local.key_arns
  }
}

data "aws_iam_policy_document" "key_merged" {
  source_json   = data.aws_iam_policy_document.key_decrypt_only.json
  override_json = data.aws_iam_policy_document.key_full_access.json
}

