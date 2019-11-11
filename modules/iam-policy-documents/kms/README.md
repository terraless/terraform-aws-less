# KMS

Common policy document for KMS

IAM policy

- full access
- decrypt only

Key policy

- full access
- decrypt only

Note that you need to trust the AWS identifier in key policy to use the key.

## Usage

``` hcl
module "iam_policy_documents_kms" {
  source = "../aws//iam-policy-documents/kms"
  ...
}
```

Note that `//` is mandatory for resolving relative module source.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id |  | string | `"AWS account ID"` | no |
| aws\_partition | AWS partition, e.g. aws, aws-cn | string | `""` | no |
| aws\_region | AWS region | string | `""` | no |
| decrypt\_only\_aws\_identifiers | AWS identifiers trusted for decrypt only | list | `<list>` | no |
| full\_access\_aws\_identifiers | AWS identifiers trusted for full access | list | `<list>` | no |
| keys | KMS key ids | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| decrypt\_only\_json | Decrypt only IAM policy document in json |
| full\_access\_json | Full access IAM policy document in json |
| key\_decrypt\_only\_json | Decrypt only key policy document in json |
| key\_full\_access\_json | Full access key policy document in json |
| key\_merged\_json | Combinded key policy document in json |
