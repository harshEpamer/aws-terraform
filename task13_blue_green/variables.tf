variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the existing VPC"
  type        = string
}

variable "public_subnet1_name" {
  description = "Name tag of the first public subnet"
  type        = string
}

variable "public_subnet2_name" {
  description = "Name tag of the second public subnet"
  type        = string
}

variable "sg_ssh_name" {
  description = "Name of the SSH security group"
  type        = string
}

variable "sg_http_name" {
  description = "Name of the HTTP security group"
  type        = string
}

variable "sg_lb_name" {
  description = "Name of the load balancer security group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for launch templates"
  type        = string
}

variable "blue_weight" {
  description = "Traffic weight for the blue target group (0-100)"
  type        = number
}

variable "green_weight" {
  description = "Traffic weight for the green target group (0-100)"
  type        = number
}
