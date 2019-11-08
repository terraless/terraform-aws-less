output "firehose_delivery_stream_arns" {
  description = "Firehose delivery stream ARNs"
  value = formatlist(
    local.regional_per_account_format,
    "firehose",
    "deliverystream/",
    var.firehose_delivery_streams,
  )
}

output "iam_group_arns" {
  description = "IAM group ARNs"
  value       = data.aws_iam_group.this.*.arn
}

output "iam_role_arns" {
  description = "IAM role ARNs"
  value       = data.aws_iam_role.this.*.arn
}

output "iam_root_arn" {
  description = "IAM root ARN"
  value       = format(local.per_account_format, "iam", "", "root")
}

output "iam_user_arns" {
  description = "IAM user ARNs"
  value       = data.aws_iam_user.this.*.arn
}

output "kms_key_arns" {
  description = "KMS key ARNs"
  value = formatlist(
    local.regional_per_account_format,
    "kms",
    "key/",
    var.kms_keys,
  )
}

output "s3_bucket_arns" {
  description = "S3 bucket ARNs"
  value       = formatlist(local.global_format, "s3", "", var.s3_buckets)
}

output "sns_topic_arns" {
  description = "SNS topic ARNs"
  value       = formatlist(local.regional_per_account_format, "sns", "", var.sns_topics)
}

output "sqs_queue_arns" {
  description = "SQS queue ARNs"
  value       = formatlist(local.regional_per_account_format, "sqs", "", var.sqs_queues)
}

output "route53_zone_arns" {
  description = "Route53 hosted zone ARNs"
  value = formatlist(
    local.global_format,
    "route53",
    "hostedzone/",
    data.aws_route53_zone.this.*.zone_id,
  )
}

output "route53_all_change_arn" {
  description = "Route53 all change ARN"
  value       = format(local.global_format, "route53", "change/", "*")
}

