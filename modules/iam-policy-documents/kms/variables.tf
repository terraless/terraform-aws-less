variable "keys" {
  description = "KMS key ids"
  default     = ["*"]
}

variable "decrypt_only_aws_identifiers" {
  description = "AWS identifiers trusted for decrypt only"
  default     = []
}

variable "full_access_aws_identifiers" {
  description = "AWS identifiers trusted for full access"
  default     = []
}

variable "aws_partition" {
  description = "AWS partition, e.g. aws, aws-cn"
  default     = ""
}

variable "aws_region" {
  description = "AWS region"
  default     = ""
}

variable "aws_account_id" {
  description = "AWS account ID"
  default     = ""
}
