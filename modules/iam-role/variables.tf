variable "name" {
  description = "IAM role name"
  default     = ""
}

variable "trusted_entities" {
  description = "Trusted entities that can assume this role."
  default = {
    "AWS" : []
    "Service" : []
  }
}
