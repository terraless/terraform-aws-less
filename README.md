# terraform-aws-less

Less is needed to provision in AWS.

## Examples

```hcl
module "s3_buckets" {
  source                      = "git::https://github.com/terraless/terraform-aws-less.git//modules/s3-buckets"
  buckets                     = [var.name]
  allow_full_access_iam_roles = concat([module.iam_role.name], var.allow_full_access_iam_roles)
}

module "iam_role" {
  name   = var.name
  source = "git::https://github.com/terraless/terraform-aws-less.git//modules/iam-role"
  trusted_entities = {
    AWS = var.trusted_entities_aws
  }
}

module "iam_role" {
  source = "git::https://github.com/terraless/terraform-aws-less.git//modules/iam-role"
  trusted_entities = {
    Service = [
      "ec2.amazonaws.com"
    ]
  }
}

module "route53_iam_policy_document" {
  source = "git::https://github.com/terraless/terraform-aws-less.git//modules/iam-policy-documents/route53"

  zones = [var.route53_zone_name]
}
```
