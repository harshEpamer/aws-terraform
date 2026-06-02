variable "project_id" {
  description = "Project identifier used for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG and ALB"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "ID of the SSH security group to attach to EC2 instances"
  type        = string
}

variable "private_http_sg_id" {
  description = "ID of the private HTTP security group to attach to EC2 instances"
  type        = string
}

variable "public_http_sg_id" {
  description = "ID of the public HTTP security group to attach to the load balancer"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
}

variable "lt_name" {
  description = "Name of the launch template"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling group"
  type        = string
}

variable "lb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
