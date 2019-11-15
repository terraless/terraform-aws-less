variable "buckets" {
  description = "S3 buckets"
  default     = []
}

module "arns_this" {
  source     = "../../arns"
  s3_buckets = var.buckets
}

module "arns_all" {
  source     = "../../arns"
  s3_buckets = ["*"]
}

data "aws_iam_policy_document" "base" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = module.arns_all.s3_bucket_arns
  }
}

data "aws_iam_policy_document" "full_access" {
  source_json = data.aws_iam_policy_document.base.json

  statement {
    actions = [
      "s3:*",
    ]

    resources = concat(
      module.arns_this.s3_bucket_arns,
      formatlist("%s/*", module.arns_this.s3_bucket_arns)
    )
  }
}

data "aws_iam_policy_document" "read_only" {
  source_json = data.aws_iam_policy_document.base.json

  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = concat(
      module.arns_this.s3_bucket_arns,
      formatlist("%s/*", module.arns_this.s3_bucket_arns)
    )
  }
}

data "aws_iam_policy_document" "read_write" {
  source_json = data.aws_iam_policy_document.base.json

  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]

    resources = concat(
      module.arns_this.s3_bucket_arns,
      formatlist("%s/*", module.arns_this.s3_bucket_arns)
    )
  }
}

output "full_access_json" {
  description = "S3 bucket full access IAM policy document"
  value       = data.aws_iam_policy_document.full_access.json
}

output "read_only_json" {
  description = "S3 bucket read only IAM policy document"
  value       = data.aws_iam_policy_document.read_only.json
}

output "read_write_json" {
  description = "S3 bucket read write IAM policy document"
  value       = data.aws_iam_policy_document.read_write.json
}
