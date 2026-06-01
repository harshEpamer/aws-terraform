resource "aws_launch_template" "blue" {
  name = "${var.project_id}-blue-template"

  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.ssh.id, data.aws_security_group.http.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = "${var.project_id}-blue" })
  }

  tags = local.common_tags
}

resource "aws_launch_template" "green" {
  name = "${var.project_id}-green-template"

  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.ssh.id, data.aws_security_group.http.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = "${var.project_id}-green" })
  }

  tags = local.common_tags
}

resource "aws_autoscaling_group" "blue" {
  name                = "${var.project_id}-blue-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]
  target_group_arns   = [aws_lb_target_group.blue.arn]

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
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
}

resource "aws_autoscaling_group" "green" {
  name                = "${var.project_id}-green-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]
  target_group_arns   = [aws_lb_target_group.green.arn]

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
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
}
