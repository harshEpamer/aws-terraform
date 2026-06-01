resource "aws_lb" "main" {
  name               = "${var.project_id}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]

  tags = local.common_tags
}

resource "aws_lb_target_group" "blue" {
  name     = "${var.project_id}-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = local.common_tags
}

resource "aws_lb_target_group" "green" {
  name     = "${var.project_id}-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = local.common_tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }

  tags = local.common_tags
}
