data "aws_instance" "public" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private" {
  instance_id = var.private_instance_id
}

# ── SSH Security Group ────────────────────────────────────────────────────────

resource "aws_security_group" "ssh" {
  name   = var.ssh_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.ssh_sg_name
    Project = var.project_tag
  }
}

resource "aws_security_group_rule" "ssh_ingress_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "ssh_ingress_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "ssh_egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# ── Public HTTP Security Group ────────────────────────────────────────────────

resource "aws_security_group" "public_http" {
  name   = var.public_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.public_http_sg_name
    Project = var.project_tag
  }
}

resource "aws_security_group_rule" "public_http_ingress_http" {
  type              = "ingress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_http_ingress_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_http_egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# ── Private HTTP Security Group ───────────────────────────────────────────────

resource "aws_security_group" "private_http" {
  name   = var.private_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.private_http_sg_name
    Project = var.project_tag
  }
}

resource "aws_security_group_rule" "private_http_ingress_http" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_http.id
  protocol                 = "tcp"
  from_port                = 8080
  to_port                  = 8080
  source_security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "private_http_ingress_icmp" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_http.id
  protocol                 = "icmp"
  from_port                = -1
  to_port                  = -1
  source_security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "private_http_egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.private_http.id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# ── Attach Security Groups to EC2 Instances ───────────────────────────────────

resource "aws_network_interface_sg_attachment" "ssh_public" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

resource "aws_network_interface_sg_attachment" "public_http_public" {
  security_group_id    = aws_security_group.public_http.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

resource "aws_network_interface_sg_attachment" "ssh_private" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.private.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_http_private" {
  security_group_id    = aws_security_group.private_http.id
  network_interface_id = data.aws_instance.private.network_interface_id
}
