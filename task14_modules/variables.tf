variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for resource naming and tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet configurations with name, CIDR block, and availability zone"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
}

variable "allowed_ip_ranges" {
  description = "List of CIDR blocks allowed for SSH and HTTP ingress access"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
}
