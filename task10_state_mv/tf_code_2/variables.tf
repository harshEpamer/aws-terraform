variable "aws_region" {
  description = "AWS region where resources are managed"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging and naming"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy being managed"
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy"
  type        = string
}
