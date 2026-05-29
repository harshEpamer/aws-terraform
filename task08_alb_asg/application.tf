data "aws_vpc" "main" {
  filter {
    name   = "cidr-block"
    values = [var.vpc_cidr]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "cidr-block"
    values = [var.public_subnet_a_cidr]
  }
}

data "aws_subnet" "public_b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "cidr-block"
    values = [var.public_subnet_b_cidr]
  }
}

data "aws_security_group" "ec2" {
  filter {
    name   = "group-name"
    values = [var.ec2_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = [var.http_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_security_group" "alb" {
  filter {
    name   = "group-name"
    values = [var.alb_security_group_name]
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
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  common_tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_launch_template" "app" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [
      data.aws_security_group.ec2.id,
      data.aws_security_group.http.id,
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    set -e

    dnf -y update || yum -y update
    dnf -y install httpd jq || yum -y install httpd jq

    systemctl enable httpd
    systemctl start httpd

    TOKEN=$(curl -sS -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    INSTANCE_ID=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/instance-id")
    PRIVATE_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/local-ipv4")

    cat > /var/www/html/index.html <<HTML
    <html>
      <head><title>Load Balanced App</title></head>
      <body>
        <h1>Application is running</h1>
        <p>Instance ID: $INSTANCE_ID</p>
        <p>Private IP: $PRIVATE_IP</p>
      </body>
    </html>
    HTML
  EOT
  )

  tags = merge(local.common_tags, {
    Name = var.launch_template_name
  })

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = var.launch_template_name
    })
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(local.common_tags, {
      Name = var.launch_template_name
    })
  }
}

resource "aws_autoscaling_group" "app" {
  name             = var.autoscaling_group_name
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id,
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }
}

resource "aws_lb" "app" {
  name               = var.load_balancer_name
  load_balancer_type = "application"
  internal           = false
  security_groups    = [data.aws_security_group.alb.id]
  subnets = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id,
  ]

  tags = merge(local.common_tags, {
    Name = var.load_balancer_name
  })
}

resource "aws_lb_target_group" "app" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
    matcher             = "200"
  }

  tags = merge(local.common_tags, {
    Name = var.target_group_name
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  lb_target_group_arn    = aws_lb_target_group.app.arn
}
