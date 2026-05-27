output "key_pair_name" {
  description = "Name of the AWS key pair registered in AWS"
  value       = aws_key_pair.this.key_name
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "instance_public_dns" {
  description = "Public DNS hostname of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "vpc_id" {
  description = "ID of the VPC resolved via data source"
  value       = data.aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet the instance was launched into"
  value       = data.aws_subnets.public.ids[0]
}

output "security_group_id" {
  description = "ID of the security group attached to the instance"
  value       = data.aws_security_group.ssh.id
}

output "ssh_command" {
  description = "Ready-to-use SSH command to connect to the instance"
  value       = "ssh -i <path-to-private-key> ec2-user@${aws_instance.this.public_ip}"
}
