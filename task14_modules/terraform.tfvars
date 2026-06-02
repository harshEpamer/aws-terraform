aws_region = "eu-west-1"
project_id = "cmtr-0g1jc0vy"
vpc_cidr   = "10.10.0.0/16"

subnets = [
  { name = "cmtr-0g1jc0vy-subnet-public-a", cidr = "10.10.1.0/24", az = "eu-west-1a" },
  { name = "cmtr-0g1jc0vy-subnet-public-b", cidr = "10.10.3.0/24", az = "eu-west-1b" },
  { name = "cmtr-0g1jc0vy-subnet-public-c", cidr = "10.10.5.0/24", az = "eu-west-1c" },
]

allowed_ip_ranges = ["18.153.146.156/32", "203.170.48.2/32"]
instance_type     = "t3.micro"
