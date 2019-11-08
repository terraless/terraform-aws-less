output "iam_root" {
  description = "IAM root ARN"
  value       = format(local.per_account_format, "iam", "", "root")
}

output "caller_identity" {
  description = "Caller identity"
  value       = data.aws_caller_identity.current.arn
}

output "s3_buckets" {
  description = "S3 bucket ARNs"
  value       = formatlist(local.global_format, "s3", "", var.s3_buckets)
}

