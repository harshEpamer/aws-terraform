provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

module "network" {
  source = "./modules/network"

  vpc_name    = "${var.project_id}-vpc"
  vpc_cidr    = var.vpc_cidr
  igw_name    = "${var.project_id}-igw"
  rt_name     = "${var.project_id}-rt"
  subnets     = var.subnets
  common_tags = local.common_tags
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id               = module.network.vpc_id
  ssh_sg_name          = "${var.project_id}-ssh-sg"
  public_http_sg_name  = "${var.project_id}-public-http-sg"
  private_http_sg_name = "${var.project_id}-private-http-sg"
  allowed_ip_ranges    = var.allowed_ip_ranges
  common_tags          = local.common_tags
}

module "application" {
  source = "./modules/application"

  project_id         = var.project_id
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.subnet_ids
  ssh_sg_id          = module.network_security.ssh_sg_id
  private_http_sg_id = module.network_security.private_http_sg_id
  public_http_sg_id  = module.network_security.public_http_sg_id
  instance_type      = var.instance_type
  lt_name            = "${var.project_id}-template"
  asg_name           = "${var.project_id}-asg"
  lb_name            = "${var.project_id}-lb"
  common_tags        = local.common_tags
}
