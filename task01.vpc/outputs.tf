output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_a_id" {
  description = "The ID of public subnet A"
  value       = aws_subnet.public_a.id
}

output "subnet_b_id" {
  description = "The ID of public subnet B"
  value       = aws_subnet.public_b.id
}

output "subnet_c_id" {
  description = "The ID of public subnet C"
  value       = aws_subnet.public_c.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "rt_id" {
  description = "The ID of the route table"
  value       = aws_route_table.rt.id
}