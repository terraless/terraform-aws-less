# ec2-instance

```hcl
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.43"
}

provider "http" {
  version = "~> 1.1"
}

module "ec2" {
  source = "github.com/terraless/terraform-aws-less.git//modules/ec2-instance"
}

output "ssh_command" {
  value = "ssh ubuntu@${module.ec2.public_ip}"
}
```

