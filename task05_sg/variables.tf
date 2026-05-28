variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
}

variable "vpc_id" {
  description = "ID of the pre-existing VPC in which the security groups will be created"
  type        = string
}

variable "public_instance_id" {
  description = "Instance ID of the pre-existing public EC2 instance"
  type        = string
}

variable "private_instance_id" {
  description = "Instance ID of the pre-existing private EC2 instance"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed to access the infrastructure via SSH, ICMP, and public HTTP"
  type        = list(string)
}

variable "ssh_sg_name" {
  description = "Name of the SSH security group"
  type        = string
}

variable "public_http_sg_name" {
  description = "Name of the public HTTP security group"
  type        = string
}

variable "private_http_sg_name" {
  description = "Name of the private HTTP security group"
  type        = string
}

variable "project_tag" {
  description = "Value for the Project tag applied to all created resources"
  type        = string
}
