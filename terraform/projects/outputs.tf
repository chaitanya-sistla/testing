#------------------------------------------------------------------------------
# IAM Role Outputs
#------------------------------------------------------------------------------

output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.read_only.arn
}

output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.read_only.name
}

output "role_id" {
  description = "Unique ID of the IAM role"
  value       = aws_iam_role.read_only.id
}

#------------------------------------------------------------------------------
# IAM Policy Outputs
#------------------------------------------------------------------------------

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.read_only.arn
}

output "policy_name" {
  description = "Name of the IAM policy"
  value       = aws_iam_policy.read_only.name
}

output "policy_id" {
  description = "Unique ID of the IAM policy"
  value       = aws_iam_policy.read_only.id
}