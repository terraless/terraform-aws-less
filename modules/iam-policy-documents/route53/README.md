# Route 53

``` hcl
module "route53_iam_policy_document" {
  source = "../aws//iam-policy-documents/route53"

  zones = "${var.route53_zones}"
}
```

Note that `//` is mandatory for resolving relative module source.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| zones | Route 53 hosted zones | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| full\_access\_json | IAM policy document in json allowing full access |
