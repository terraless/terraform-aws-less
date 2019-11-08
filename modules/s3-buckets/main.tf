variable "buckets" {
  description = "S3 buckets"
  type        = list(string)
}

variable "allow_full_access_iam_roles" {
  description = "Allow full access from roles"
  default     = []
}

variable "allow_full_access_iam_users" {
  description = "Allow full access from users"
  default     = []
}

module "arns" {
  source = "../arns"

  iam_roles = var.allow_full_access_iam_roles
  iam_users = var.allow_full_access_iam_users
}

module "iam_policy_documents" {
  source  = "../iam-policy-documents/s3"
  buckets = var.buckets
}

resource "aws_s3_bucket" "this" {
  count = length(var.buckets)

  bucket = var.buckets[count.index]
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = length(var.buckets)

  bucket = aws_s3_bucket.this[count.index].bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role_policy" "s3_buckets" {
  count = length(var.allow_full_access_iam_roles)

  name = "s3-buckets-${md5(module.iam_policy_documents.s3_bucket_full_access)}"
  role = var.allow_full_access_iam_roles[count.index]

  policy = module.iam_policy_documents.s3_bucket_full_access
}

resource "aws_iam_user_policy" "s3_buckets" {
  count = length(var.allow_full_access_iam_users)

  name = "s3-buckets-${md5(module.iam_policy_documents.s3_bucket_full_access)}"
  user = var.allow_full_access_iam_users[count.index]

  policy = module.iam_policy_documents.s3_bucket_full_access
}

output "buckets" {
  description = "S3 buckets"
  value       = aws_s3_bucket.this.*.bucket
}

