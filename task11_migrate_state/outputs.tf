output "policy_arn" {
  description = "ARN of the IAM policy managed after state migration"
  value       = aws_iam_policy.custom_policy.arn
}
