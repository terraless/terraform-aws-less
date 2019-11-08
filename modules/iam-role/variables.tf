variable "role_name" {
  description = "IAM role name"
  default     = ""
}

variable "trusted_aws_identifiers" {
  description = "Trusted AWS identifiers"
  default     = []
}

variable "trusted_identity_providers" {
  description = "Trusted identity providers"
  default     = []
}

variable "service_role" {
  description = "IAM role for service"
  default     = ""
}

