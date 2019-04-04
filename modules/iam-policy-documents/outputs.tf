output "s3_bucket_full_access" {
  description = "S3 bucket full access IAM policy document"
  value       = "${data.aws_iam_policy_document.s3_full_access.json}"
}
