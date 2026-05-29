aws_region = "eu-west-1"

project_id = "cmtr-0g1jc0vy"

vpc_name = "cmtr-0g1jc0vy-vpc"
vpc_cidr = "10.0.0.0/16"

public_subnet_a_cidr = "10.0.1.0/24"
public_subnet_b_cidr = "10.0.3.0/24"

ec2_security_group_name  = "cmtr-0g1jc0vy-ec2_sg"
http_security_group_name = "cmtr-0g1jc0vy-http_sg"
alb_security_group_name  = "cmtr-0g1jc0vy-sglb"

key_pair_name = "cmtr-0g1jc0vy-keypair"

instance_profile_name = "cmtr-0g1jc0vy-instance_profile"

launch_template_name   = "cmtr-0g1jc0vy-template"
autoscaling_group_name = "cmtr-0g1jc0vy-asg"
load_balancer_name     = "cmtr-0g1jc0vy-loadbalancer"
target_group_name      = "cmtr-0g1jc0vy-target-group"

instance_type = "t3.micro"

min_size         = 1
max_size         = 2
desired_capacity = 2

listener_port = 80
