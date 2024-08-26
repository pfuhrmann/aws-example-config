module "vpc" {
  source      = "../../modules/vpc"
  environment = local.environment
  aws_region  = var.aws_region
  name_prefix = var.subdomain

  vpc_cidr_block = "10.0.0.0/23"
  public_subnet_cidr_blocks = ["10.0.0.0/27", "10.0.0.32/27"]
  private_subnet_cidr_blocks = ["10.0.1.0/27", "10.0.1.32/27"]
}

module "nat" {
  source      = "../../modules/nat"
  environment = local.environment
  aws_region  = var.aws_region
  name_prefix = var.subdomain

  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_ids[0]
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "elb_public" {
  source      = "../../modules/elb-public"
  environment = local.environment
  aws_region  = var.aws_region
  name_prefix = var.subdomain

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "simple_website" {
  source      = "../../modules/ec2-private"
  environment = local.environment
  aws_region  = var.aws_region
  name_prefix = var.subdomain

  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  elb_id                  = module.elb_public.elb_id
  elb_dns_name            = module.elb_public.elb_dns_name
  elb_target_group_arn    = module.elb_public.elb_target_group_arn
  elb_security_group_name = module.elb_public.elb_security_group_name
  subdomain               = var.subdomain
  hosted_zone_name        = var.hosted_zone_name
}
