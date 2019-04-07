provider "aws" {
  version = "~>2.4.0"
  region  = "us-east-1"
}

module "s3_buckets" {
  source  = "../../modules//s3-buckets"
  buckets = ["example"]

  allow_full_access_iam_roles = ["${module.iam_role_example.service}"]
  allow_full_access_iam_users = ["${aws_iam_user.example.name}"]
}

module "iam_role_example" {
  source = "../../modules//iam-role"

  service_role               = "example"
  trusted_identity_providers = ["ec2.amazonaws.com"]
}

resource "aws_iam_user" "example" {
  name = "example"
}
