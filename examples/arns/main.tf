provider "aws" {
  version = "~>2.4.0"
  region  = "us-east-1"
}

module "arns" {
  source = "../../modules//arns"
}

output "iam_root" {
  value = "${module.arns.iam_root}"
}

output "caller_identity" {
  value = "${module.arns.caller_identity}"
}
