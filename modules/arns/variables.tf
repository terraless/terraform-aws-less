variable "iam_groups" {
  description = "IAM group names"
  default     = []
}

variable "iam_roles" {
  description = "IAM role names"
  default     = []
}

variable "iam_users" {
  description = "IAM user names"
  default     = []
}

variable "kms_keys" {
  description = "KMS key IDs"
  default     = []
}

variable "s3_buckets" {
  description = "S3 bucket names"
  default     = []
}

variable "sns_topics" {
  description = "SNS topic names"
  default     = []
}

variable "sqs_queues" {
  description = "SQS queue names"

  default = []
}

variable "partition" {
  description = "AWS partition, e.g. aws, aws-cn"
  default     = ""
}

variable "account_id" {
  description = "AWS account ID"
  default     = ""
}

variable "region" {
  description = "AWS region name"
  default     = ""
}

