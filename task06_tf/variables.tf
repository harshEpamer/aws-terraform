variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_a_name" {
  description = "Name of public subnet A (eu-west-1a)"
  type        = string
}

variable "subnet_a_az" {
  description = "Availability Zone for public subnet A"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "subnet_b_name" {
  description = "Name of public subnet B (eu-west-1b)"
  type        = string
}

variable "subnet_b_az" {
  description = "Availability Zone for public subnet B"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "subnet_c_name" {
  description = "Name of public subnet C (eu-west-1c)"
  type        = string
}

variable "subnet_c_az" {
  description = "Availability Zone for public subnet C"
  type        = string
}

variable "subnet_c_cidr" {
  description = "CIDR block for public subnet C"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "rt_name" {
  description = "Name of the route table"
  type        = string
}
