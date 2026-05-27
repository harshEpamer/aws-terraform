variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_a_name" {
  description = "The name of the public subnet A"
  type        = string
}

variable "subnet_a_cidr" {
  description = "The CIDR block for public subnet A"
  type        = string
}

variable "subnet_b_name" {
  description = "The name of the public subnet B"
  type        = string
}

variable "subnet_b_cidr" {
  description = "The CIDR block for public subnet B"
  type        = string
}

variable "subnet_c_name" {
  description = "The name of the public subnet C"
  type        = string
}

variable "subnet_c_cidr" {
  description = "The CIDR block for public subnet C"
  type        = string
}

variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

variable "rt_name" {
  description = "The name of the route table"
  type        = string
}