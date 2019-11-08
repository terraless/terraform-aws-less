# terraform-aws-arns

Format AWS ARNs from resource id or name.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | AWS account ID | string | `""` | no |
| iam\_groups | IAM group names | list | `<list>` | no |
| iam\_roles | IAM role names | list | `<list>` | no |
| iam\_users | IAM user names | list | `<list>` | no |
| kms\_keys | KMS key IDs | list | `<list>` | no |
| partition | AWS partition, e.g. aws, aws-cn | string | `""` | no |
| region | AWS region name | string | `""` | no |
| route53\_zones | Route53 hosted zones | list | `<list>` | no |
| s3\_buckets | S3 bucket names | list | `<list>` | no |
| sns\_topics | SNS topic names | list | `<list>` | no |
| sqs\_queues | SQS queue names | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_group\_arns | IAM group ARNs |
| iam\_role\_arns | IAM role ARNs |
| iam\_root\_arn | IAM root ARN |
| iam\_user\_arns | IAM user ARNs |
| kms\_key\_arns | KMS key ARNs |
| route53\_all\_change\_arn | Route53 all change ARN |
| route53\_zone\_arns | Route53 hosted zone ARNs |
| s3\_bucket\_arns | S3 bucket ARNs |
| sns\_topic\_arns | SNS topic ARNs |
| sqs\_queue\_arns | SQS queue ARNs |
