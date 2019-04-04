provider "aws" {
  version = "~>2.4.0"
  region  = "us-east-1"
}

module "iam_policy_documents" {
  source     = "../../modules//iam-policy-documents"
  s3_buckets = ["bucket"]
}

output "s3_bucket_full_access" {
  description = "S3 bucket full access"
  value       = "${module.iam_policy_documents.s3_bucket_full_access}"
}
