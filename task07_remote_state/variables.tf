variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for resource tagging and naming"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket name that stores the remote Terraform state"
  type        = string
}

variable "state_key" {
  description = "S3 key path to the remote state file"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
