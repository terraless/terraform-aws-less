module "arns" {
  source = "../arns"
}

resource "aws_iam_role" "this" {
  name = var.name

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    dynamic "principals" {
      for_each = var.trusted_entities

      content {
        type        = principals.key
        identifiers = principals.value
      }
    }
  }
}

output "name" {
  description = "IAM role name"
  value       = aws_iam_role.this.name
}
