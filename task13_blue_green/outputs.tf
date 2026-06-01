output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "blue_tg_arn" {
  description = "ARN of the blue target group"
  value       = aws_lb_target_group.blue.arn
}

output "green_tg_arn" {
  description = "ARN of the green target group"
  value       = aws_lb_target_group.green.arn
}
