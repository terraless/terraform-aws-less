output "full_access_json" {
  description = "IAM policy document in json allowing full access"
  value       = data.aws_iam_policy_document.full_access.json
}

