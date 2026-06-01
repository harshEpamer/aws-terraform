resource "aws_instance" "main" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [data.aws_security_group.instance.id]

  tags = {
    Name      = var.instance_name
    Terraform = "true"
    Project   = var.project_id
  }
}
