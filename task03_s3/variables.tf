variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name of the S3 bucket to create"
  type        = string
}

variable "project_tag" {
  description = "Value for the Project tag applied to all created resources"
  type        = string
}
