resource "aws_iam_policy" "custom_policy" {
  name        = var.policy_name
  path        = "/"
  description = var.policy_description

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:*", "s3:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
