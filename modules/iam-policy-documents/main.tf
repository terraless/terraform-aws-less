variable "s3_buckets" {
  description = "S3 buckets"
  default     = []
}

module "arns_this" {
  source     = "../arns"
  s3_buckets = "${var.s3_buckets}"
}

module "arns_all" {
  source     = "../arns"
  s3_buckets = ["*"]
}

data "aws_iam_policy_document" "s3_full_access" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "${module.arns_all.s3_buckets}",
    ]
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = ["${concat(
        module.arns_this.s3_buckets,
        formatlist("%s/*", module.arns_this.s3_buckets)
    )}"]
  }
}
