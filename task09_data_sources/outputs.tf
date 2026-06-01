output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the created EC2 instance"
  value       = aws_instance.main.public_ip
}

output "discovered_vpc_id" {
  description = "ID of the discovered VPC"
  value       = data.aws_vpc.main.id
}

output "discovered_public_subnet_id" {
  description = "ID of the discovered public subnet"
  value       = data.aws_subnet.public.id
}

output "discovered_security_group_id" {
  description = "ID of the discovered security group"
  value       = data.aws_security_group.instance.id
}
