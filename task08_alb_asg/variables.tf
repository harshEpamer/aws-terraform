variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the pre-created VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the pre-created VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block of pre-created public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block of pre-created public subnet B"
  type        = string
}

variable "ec2_security_group_name" {
  description = "Name of pre-created security group for SSH access to EC2"
  type        = string
}

variable "http_security_group_name" {
  description = "Name of pre-created security group for HTTP access to EC2"
  type        = string
}

variable "alb_security_group_name" {
  description = "Name of pre-created security group for ALB"
  type        = string
}

variable "key_pair_name" {
  description = "Name of pre-created EC2 key pair"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of pre-created IAM instance profile"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the launch template to create"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group to create"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer to create"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the Application Load Balancer"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "listener_port" {
  description = "Port used by the ALB HTTP listener"
  type        = number
}
