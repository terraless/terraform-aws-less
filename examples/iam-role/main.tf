provider "aws" {
  version = "~>2.4.0"
  region  = "us-east-1"
}

module "iam_role" {
  source = "../../modules//iam-role"
  name   = "example"
}
