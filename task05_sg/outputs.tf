output "ssh_sg_id" {
  description = "ID of the SSH security group"
  value       = aws_security_group.ssh.id
}

output "public_http_sg_id" {
  description = "ID of the public HTTP security group"
  value       = aws_security_group.public_http.id
}

output "private_http_sg_id" {
  description = "ID of the private HTTP security group"
  value       = aws_security_group.private_http.id
}

output "public_instance_eni" {
  description = "Primary network interface ID of the public EC2 instance"
  value       = data.aws_instance.public.network_interface_id
}

output "private_instance_eni" {
  description = "Primary network interface ID of the private EC2 instance"
  value       = data.aws_instance.private.network_interface_id
}
