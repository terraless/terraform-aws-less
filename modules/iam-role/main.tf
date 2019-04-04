locals = {
  trusted_aws_identifiers = "${distinct(concat(var.trusted_aws_identifiers, list(module.arns.iam_root)))}"
}

module "arns" {
  source = "../arns"
}

resource "aws_iam_role" "this" {
  name = "${var.name}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "AWS"
      identifiers = "${var.trusted_aws_identifiers}"
    }
  }
}
