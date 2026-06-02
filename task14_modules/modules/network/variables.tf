variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "rt_name" {
  description = "Name tag for the route table"
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

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
