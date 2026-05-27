variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
}

variable "vpc_name" {
  description = "Name of the pre-created VPC to look up via data source"
  type        = string
}

variable "sg_name" {
  description = "Name of the pre-created security group to look up via data source"
  type        = string
}

variable "keypair_name" {
  description = "Name of the AWS key pair resource to create in AWS"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance to create"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "project_tag" {
  description = "Value for the Project tag applied to all created resources"
  type        = string
}

variable "id_tag" {
  description = "Value for the ID tag applied to all created resources"
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key"
  type        = string
}
