################################################################################
# VPC
################################################################################
module "vpc" {
  source = "./modules/vpc"

  # Passing variables FROM root TO module
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  vpc_azs              = var.vpc_availability_zones
  vpc_private_subnets  = var.vpc_private_subnets
  vpc_public_subnets   = var.vpc_public_subnets
  vpc_database_subnets = var.vpc_database_subnets

  vpc_create_database_subnet_group       = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  vpc_enable_nat_gateway                 = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway                 = var.vpc_single_nat_gateway

  # Passing computed values from locals
  prefix      = local.prefix
  common_tags = local.common_tags
}

################################################################################
# Security groups
################################################################################
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  common_tags    = local.common_tags
  prefix         = local.prefix
}

################################################################################
# EC2 instances for this project (bastion, b2b, b2c)
################################################################################

module "ec2_instance_bastion" {
  source = "./modules/ec2/bastion"

  depends_on                = [module.vpc]
  prefix                    = local.prefix
  common_tags               = local.common_tags
  instance_type             = var.instance_type
  ami_ubuntu_id             = data.aws_ami.ubuntu_ami.id
  instance_keypair          = var.instance_keypair
  bastion_subnet_id         = module.vpc.public_subnets[0]
  bastion_security_group_id = module.security_groups.public_bastion_sg_group_id
}

module "ec2_instance_b2b" {
  source = "./modules/ec2/b2b"

  depends_on                = [module.vpc]
  prefix                    = local.prefix
  common_tags               = local.common_tags
  instance_type             = var.instance_type
  ami_ubuntu_id             = data.aws_ami.ubuntu_ami.id
  instance_keypair          = var.instance_keypair
  private_subnet_ids        = module.vpc.private_subnets
  private_security_group_id = module.security_groups.private_sg_group_id
}

module "ec2_instance_b2c" {
  source = "./modules/ec2/b2c"

  depends_on                = [module.vpc]
  prefix                    = local.prefix
  common_tags               = local.common_tags
  instance_type             = var.instance_type
  ami_linux_id              = data.aws_ami.amazon_linux_ami.id
  instance_keypair          = var.instance_keypair
  private_subnet_ids        = module.vpc.private_subnets
  private_security_group_id = module.security_groups.private_sg_group_id
}

################################################################################
# Load balancers (CLB, ALB_without_ASG, ALB_path_routing)
################################################################################

/*
# Create CLB 

module "classic_load_balancer" {
  source = "./modules/load-balancers/clb"

  #from locals
  prefix      = local.prefix
  common_tags = local.common_tags

  # From vpc module
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnets

  #from sg module
  clb_sg_id = module.security_groups.clb_sg_group_id

  # from ec2 module
  ec2_private_ids        = module.ec2_instances.ec2_private_b2b_id
  private_instance_count = length(module.ec2_instances.ec2_private_b2b_id)
}


# Create ALB without ASG

module "alb_without_asg" {
  source = "./modules/load-balancers/alb-basic"

  prefix             = local.prefix
  common_tags        = local.common_tags
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnets
  alb_sg_id          = module.security_groups.alb_sg_group_id
  ec2_private_ids    = module.ec2_instance_b2b.ec2_private_b2b_id
}

module "alb_path_routing" {
  source = "./modules/load-balancers/alb-path"

  prefix              = local.prefix
  common_tags         = local.common_tags
  vpc_id              = module.vpc.vpc_id
  public_subnets_ids  = module.vpc.public_subnets
  alb_sg_id           = module.security_groups.alb_sg_group_id
  ec2_private_b2b_ids = module.ec2_instance_b2b.ec2_private_b2b_id
  ec2_private_b2c_ids = module.ec2_instance_b2c.ec2_private_b2c_id
  acm_certificate_arn = module.acm.acm_certificate_arn
}

*/

module "acm" {
  source = "./modules/acm"

  common_tags = local.common_tags
  domain_name = data.aws_route53_zone.domain.name
  zone_id     = data.aws_route53_zone.domain.zone_id

}

module "alb_host_header_routing" {
  source = "./modules/load-balancers/alb-host-header"

  prefix              = local.prefix
  common_tags         = local.common_tags
  vpc_id              = module.vpc.vpc_id
  public_subnets_ids  = module.vpc.public_subnets
  alb_sg_id           = module.security_groups.alb_sg_group_id
  ec2_private_b2b_ids = module.ec2_instance_b2b.ec2_private_b2b_id
  ec2_private_b2c_ids = module.ec2_instance_b2c.ec2_private_b2c_id
  acm_certificate_arn = module.acm.acm_certificate_arn
  api                 = aws_route53_record.api.name
  web                 = aws_route53_record.web.name
}



