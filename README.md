# terraform-aws-less

Less is needed to provision in AWS.

## Examples

```hcl
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
