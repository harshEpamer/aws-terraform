import {
  to = aws_iam_policy.main
  id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.policy_name}"
}

resource "aws_iam_policy" "main" {
  name        = var.policy_name
  path        = "/"
  description = var.policy_description

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:*", "s3:*"]
        Resource = "*"
      }
    ]
  })
}
