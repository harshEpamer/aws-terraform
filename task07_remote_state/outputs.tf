output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.app.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "instance_public_dns" {
  description = "Public DNS hostname of the EC2 instance"
  value       = aws_instance.app.public_dns
}

output "vpc_id_from_remote_state" {
  description = "VPC ID read from remote state"
  value       = data.terraform_remote_state.base_infra.outputs.vpc_id
}

output "public_subnet_id_from_remote_state" {
  description = "Public subnet ID read from remote state"
  value       = data.terraform_remote_state.base_infra.outputs.public_subnet_id
}

output "security_group_id_from_remote_state" {
  description = "Security group ID read from remote state"
  value       = data.terraform_remote_state.base_infra.outputs.security_group_id
}
