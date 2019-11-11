output "full_access_json" {
  description = "Full access IAM policy document in json"
  value       = data.aws_iam_policy_document.full_access.json
}

output "decrypt_only_json" {
  description = "Decrypt only IAM policy document in json"
  value       = data.aws_iam_policy_document.decrypt_only.json
}

output "key_full_access_json" {
  description = "Full access key policy document in json"
  value       = data.aws_iam_policy_document.key_full_access.json
}

output "key_decrypt_only_json" {
  description = "Decrypt only key policy document in json"
  value       = data.aws_iam_policy_document.key_decrypt_only.json
}

output "key_merged_json" {
  description = "Combinded key policy document in json"
  value       = data.aws_iam_policy_document.key_merged.json
}

