variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
}

variable "iam_group_name" {
  description = "Name of the IAM group to create"
  type        = string
}

variable "iam_policy_name" {
  description = "Name of the custom IAM policy granting S3 write access"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role that EC2 can assume"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile to associate with the IAM role"
  type        = string
}

variable "bucket_name" {
  description = "Name of the pre-existing S3 bucket referenced in the IAM policy"
  type        = string
}

variable "project_tag" {
  description = "Value for the Project tag applied to all created resources"
  type        = string
}
