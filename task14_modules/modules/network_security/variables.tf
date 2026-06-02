variable "vpc_id" {
  description = "ID of the VPC to create security groups in"
  type        = string
}

variable "ssh_sg_name" {
  description = "Name of the SSH security group"
  type        = string
}

variable "public_http_sg_name" {
  description = "Name of the public HTTP security group (used by the load balancer)"
  type        = string
}

variable "private_http_sg_name" {
  description = "Name of the private HTTP security group (used by EC2 instances)"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of CIDR blocks allowed for SSH and public HTTP ingress"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
