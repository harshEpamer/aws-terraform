data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet1_name]
  }
}

data "aws_subnet" "public2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet2_name]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = [var.sg_ssh_name]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = [var.sg_http_name]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = [var.sg_lb_name]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
