output "policy_arn" {
  description = "ARN of the IAM policy now managed by tf_code_2"
  value       = aws_iam_policy.custom_policy.arn
}
